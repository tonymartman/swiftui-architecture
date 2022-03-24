//
//  CollectionNetworkSource.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import Resolver

struct CollectionNetworkSource {
    @Injected private(set) var networkClient: NetworkClient
}

extension CollectionNetworkSource: CollectionFetchingDataSourceProtocol {
    func fetchCollection(id: String) async throws -> Collection {
        let operation = CollectionOperation(id: id)
        let collection: CollectionDTO = try await networkClient.send(operation)
        return collection.toDomain()
    }

    func fetchCollections() async throws -> [Collection] {
        let operation = MyCollectionsOperation()
        let collections: [CollectionDTO] = try await networkClient.send(operation)
        return collections.map { $0.toDomain() }
    }

    func fetchImages(id: String) async throws -> [Image] {
        let input = PaginatedIdInputType(id: id)
        let operation = CollectionImagesOperation(input: input)
        let page: ImagePaginatedType = try await networkClient.send(operation)
        return page.objects.map { $0.toDomain() }
    }
}
