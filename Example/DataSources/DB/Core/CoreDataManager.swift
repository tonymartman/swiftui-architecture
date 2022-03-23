//
//  CoreDataManager.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import CoreData

final class CoreDataManager: CoreDataManagerProtocol {
    private let modelName: String
    private let storeType: NSPersistentStore.StoreType
    private lazy var databaseUrl: URL = {
        guard let url = FileManager.default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(modelName)
                .appendingPathExtension(storeType.rawValue) else {
                    fatalError("no database url")
                }

        return url
    }()

    private let persistentContainer: NSPersistentContainer

    init(modelName: String, storeType: NSPersistentStore.StoreType = .sqlite) {
        self.modelName = modelName
        self.storeType = storeType
        persistentContainer = NSPersistentContainer(name: modelName)
        loadStore()
    }

    func fetch<T: NSManagedObject>(entity: T.Type,
                                   predicate: NSPredicate?,
                                   sorted: [NSSortDescriptor]?,
                                   context: NSManagedObjectContext?) throws -> [T] {
        let request = T.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sorted

        let ctx = context ?? createContext()
        let result = try ctx.fetch(request)
        if let result = result as? [T] {
            return result
        } else {
            fatalError("cannot cast result to \(T.self)")
        }
    }

    func fetchFirst<T: NSManagedObject>(entity: T.Type,
                                        predicate: NSPredicate?,
                                        sorted: [NSSortDescriptor]?,
                                        context: NSManagedObjectContext?) throws -> T? {
        return try fetch(entity: entity, predicate: predicate, sorted: sorted, context: context)
            .first
    }

    func createOrUpdate<T: NSManagedObject>(entity: T.Type,
                                            predicate: NSPredicate?,
                                            context: NSManagedObjectContext?,
                                            block: (T) throws -> Void) throws -> T {
        if let obj = try fetchFirst(entity: entity, predicate: predicate, sorted: nil, context: context) {
            try block(obj)
            return obj
        } else {
            return try create(entity: entity, context: context, block: block)
        }
    }

    func delete<T: NSManagedObject>(entity: T.Type,
                                    predicate: NSPredicate,
                                    context: NSManagedObjectContext?) throws {
        let ctx = context ?? createContext()
        try fetch(entity: entity, predicate: predicate, sorted: nil, context: ctx)
            .forEach { ctx.delete($0) }
    }

    func deleteAll<T: NSManagedObject>(entity: T.Type,
                                       context: NSManagedObjectContext?) throws {
        let ctx = context ?? createContext()
        try fetch(entity: T.self, predicate: nil, sorted: nil, context: ctx)
            .forEach { ctx.delete($0) }
    }

    func removeDatabase() throws {
        try persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: databaseUrl,
                                                                                  ofType: storeType.rawValue,
                                                                                  options: nil)
        loadStore()
    }

    func performSave(block: @escaping (NSManagedObjectContext) throws -> Void) async throws {
        let moc = persistentContainer.viewContext
        let privateMoc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMoc.parent = moc

        try await privateMoc.perform {
            try block(privateMoc)
            try privateMoc.save()
            try moc.performAndWait {
                try self.save()
            }
        }
    }
}

// MARK: - Private

private extension CoreDataManager {
    func loadStore() {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("persistent container error \(error.localizedDescription)")
            }
        }
    }

    func createContext() -> NSManagedObjectContext {
        if Thread.isMainThread {
            return persistentContainer.viewContext
        } else {
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.parent = persistentContainer.viewContext
            return context
        }
    }

    func create<T: NSManagedObject>(entity: T.Type,
                                    context: NSManagedObjectContext? = nil,
                                    block: CreationBlock<T>) throws -> T {
        let object = T(context: context ?? createContext())
        try block(object)
        return object
    }

    func save() throws {
        let context = persistentContainer.viewContext
        if !context.hasChanges {
            return
        }

        try context.save()
    }
}
