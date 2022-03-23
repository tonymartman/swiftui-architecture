//
//  CollectionRepository.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import Resolver

struct CollectionRepository: CollectionRepositoryProtocol {
    @Injected private(set) var networkSource: CollectionFetchingDataSourceProtocol
    @Injected private(set) var dbSource: CollectionDBSourceProtocol

    func fetchAll(_ fetchingType: FetchingType) async throws -> [Collection] {
        switch fetchingType {
        case .reloadAndCache:
            let collections = try await networkSource.fetchCollections()
            try await dbSource.save(collections: collections)
            return collections
        case .ignoreCache:
            return try await networkSource.fetchCollections()
        case .fetchFromCache:
            return try await dbSource.fetchCollections()
        }
    }

    func fetch(id: UUID, _ fetchingType: FetchingType) async throws -> Collection? {
        switch fetchingType {
        case .reloadAndCache:
            guard let collection = try await networkSource.fetchCollection(id: id) else { return nil }
            try await dbSource.save(collections: [collection])
            return collection
        case .ignoreCache:
            return try await networkSource.fetchCollection(id: id)
        case .fetchFromCache:
            return try await dbSource.fetchCollection(id: id)
        }
    }

    func save(items: [Collection]) async throws {
        try await dbSource.save(collections: items)
    }
}
