//
//  CDCollection+Domain.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import CoreData

extension CDCollection: DomainConvertible {
    func toDomain() -> Collection {
        guard let id = identifier, let name = name, let owner = owner else {
            fatalError("impossible to convert to Collection domain")
        }

        return Collection(id: id, name: name, owner: owner)
    }
}

extension Collection: ManagedObjectConvertible {
    @discardableResult func toManagedObject(manager: CoreDataManagerProtocol, context: NSManagedObjectContext) throws -> NSManagedObject {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(CDCollection.identifier), id as CVarArg)
        return try manager.createOrUpdate(entity: CDCollection.self, predicate: predicate, context: context) { object in
            object.identifier = id
            object.name = name
            object.owner = owner
        }
    }
}
