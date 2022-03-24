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
    func fetchCollection(id: UUID) async throws -> Collection? {
        // TODO: usar network client
        nil
    }

    func fetchCollections() async throws -> [Collection] {
        let operation = MyCollectionsOperation()
        let collections = try await networkClient.send(operation)
        return collections.map { $0.toDomain() }
    }
}
