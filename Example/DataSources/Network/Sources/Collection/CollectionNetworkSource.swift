//
//  CollectionNetworkSource.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

struct CollectionNetworkSource {}

extension CollectionNetworkSource: CollectionFetchingDataSourceProtocol {
    func fetchCollection(id: UUID) async throws -> Collection? {
        // TODO: usar network client
        nil
    }

    func fetchCollections() async throws -> [Collection] {
        // TODO: usar network client
        []
    }
}
