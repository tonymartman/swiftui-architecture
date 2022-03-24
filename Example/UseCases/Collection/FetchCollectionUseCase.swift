//
//  FetchCollectionUseCase.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation
import Resolver

struct FetchCollectionUseCase: FetchCollectionUseCaseProtocol {
    @Injected private var repository: CollectionRepositoryProtocol

    func fetchCollection(id: String) async throws -> Collection {
        try await repository.fetch(id: id, .ignoreCache)
    }
}
