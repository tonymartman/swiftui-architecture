//
//  ManagedObjectConvertible.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import CoreData

protocol ManagedObjectConvertible {
    func toManagedObject(manager: CoreDataManagerProtocol, context: NSManagedObjectContext) throws -> NSManagedObject
}
