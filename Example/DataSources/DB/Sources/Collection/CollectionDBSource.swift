//
//  CollectionDBSource.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import Resolver
import CoreData

struct CollectionDBSource: CollectionDBSourceProtocol {
    @Injected private(set) var dbManager: CoreDataManagerProtocol

    func fetchCollection(id: String) async throws -> Collection {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(CDCollection.identifier), id)

        guard let collection = try dbManager.fetchFirst(entity: CDCollection.self, predicate: predicate, sorted: nil, context: nil) else {
            throw FetchingDataError.itemNotFound(id: id)
        }

        return collection.toDomain()
    }

    func fetchCollections() async throws -> [Collection] {
        try dbManager.fetch(entity: CDCollection.self, predicate: nil, sorted: nil, context: nil)
            .map { $0.toDomain() }
    }

    func save(collections: [Collection]) async throws {
        try await dbManager.performSave { context in
            try collections.forEach {
                try $0.toManagedObject(manager: dbManager, context: context)
            }
        }
    }
}
