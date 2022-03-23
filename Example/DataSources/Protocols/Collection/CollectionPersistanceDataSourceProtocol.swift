//
//  CollectionPersistDataSourceProtocol.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

protocol CollectionPersistanceDataSourceProtocol {
    func save(collections: [Collection]) async throws
}
