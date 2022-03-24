//
//  CollectionFetchDataSourceProtocol.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

enum FetchingDataError: Error {
    case itemNotFound(id: String)
}

protocol CollectionFetchingDataSourceProtocol {
    func fetchCollection(id: String) async throws -> Collection
    func fetchCollections() async throws -> [Collection]
    func fetchImages(id: String) async throws -> [Image]
}
