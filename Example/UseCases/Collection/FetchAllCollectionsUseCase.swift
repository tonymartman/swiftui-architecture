//
//  FetchAllUseCase.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

struct FetchAllCollectionsUseCase: FetchAllCollectionsUseCaseProtocol {
    let repository: CollectionRepositoryProtocol

    func fetchAll() async throws -> [Collection] {
        try await repository.fetchAll(.fetchFromCache)
    }
}
