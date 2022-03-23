//
//  CollectionFetchDataSourceProtocol.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

protocol CollectionFetchingDataSourceProtocol {
    func fetchCollection(id: UUID) async throws -> Collection?
    func fetchCollections() async throws -> [Collection]
}
