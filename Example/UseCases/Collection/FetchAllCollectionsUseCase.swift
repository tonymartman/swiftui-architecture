//
//  FetchAllUseCase.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation
import Resolver

struct FetchAllCollectionsUseCase: FetchAllCollectionsUseCaseProtocol {
    @Injected private var repository: CollectionRepositoryProtocol

    func fetchAll() async throws -> [Collection] {
        try await repository.fetchAll(.fetchFromCache)
    }
}
