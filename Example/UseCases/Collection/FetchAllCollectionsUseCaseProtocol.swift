//
//  FetchAllUseCaseProtocol.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

protocol FetchAllCollectionsUseCaseProtocol {
    func fetchAll() async throws -> [Collection]
}
