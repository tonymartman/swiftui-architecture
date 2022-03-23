//
//  CoreDataManagerProtocol.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    typealias CreationBlock<T: NSManagedObject> = (T) throws -> Void
    typealias SaveBlock = (NSManagedObjectContext) throws -> Void

    func fetch<T: NSManagedObject>(entity: T.Type,
                                   predicate: NSPredicate?,
                                   sorted: [NSSortDescriptor]?,
                                   context: NSManagedObjectContext?) throws -> [T]

    func fetchFirst<T: NSManagedObject>(entity: T.Type,
                                        predicate: NSPredicate?,
                                        sorted: [NSSortDescriptor]?,
                                        context: NSManagedObjectContext?) throws -> T?

    func createOrUpdate<T: NSManagedObject>(entity: T.Type,
                                            predicate: NSPredicate?,
                                            context: NSManagedObjectContext?,
                                            block: CreationBlock<T>) throws -> T

    func delete<T: NSManagedObject>(entity: T.Type,
                                    predicate: NSPredicate,
                                    context: NSManagedObjectContext?) throws

    func deleteAll<T: NSManagedObject>(entity: T.Type,
                                       context: NSManagedObjectContext?) throws

    func removeDatabase() throws

    func performSave(block: @escaping SaveBlock) async throws
}
