// Created for Example in 2022

import Foundation

struct Collection: Domain {
    let id: UUID
    let name: String
    let owner: String
}

extension Collection {
    static func fetch(id: UUID) async -> Collection {
        try? await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
        return Collection.mock()
    }

    static func search(name: String) async -> [Collection] {
        try? await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
        return Collection.mockArray2().contains(name: name)
    }
}

enum FetchAllCollectionsError: Error {
    case error1, error2
}
