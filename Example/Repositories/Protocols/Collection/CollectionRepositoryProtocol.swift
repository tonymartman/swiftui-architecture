//
//  CollectionRepositoryProtocol.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

protocol CollectionRepositoryProtocol {
    func fetchAll(_ fetchingType: FetchingType) async throws -> [Collection]
    func fetch(id: String, _ fetchingType: FetchingType) async throws -> Collection
    func save(items: [Collection]) async throws
}
