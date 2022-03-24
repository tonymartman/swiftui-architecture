//
//  FetchCollectionUseCaseProtocol.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

protocol FetchCollectionUseCaseProtocol {
    func fetchCollection(id: String) async throws -> Collection
}
