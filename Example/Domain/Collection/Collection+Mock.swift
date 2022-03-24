// Created for Example in 2022

import Foundation

extension Collection {
    static func mock() -> Collection {
        .init(id: "68ABF1C7-6ECA-482B-996C-9693D8423BE5", name: "Movies", owner: "Tony")
    }

    static func mockArray() -> [Collection] {
        [
            .init(id: UUID().uuidString, name: "Movies", owner: "Tony"),
            .init(id: UUID().uuidString, name: "Albums", owner: "Isabel")
        ]
    }

    static func mockArray2() -> [Collection] {
        [
            .init(id: "68ABF1C7-6ECA-482B-996C-9693D8423BE5", name: "Music", owner: "Tony"),
            .init(id: "68ABF1C7-6ECA-482B-996C-9693D8423BE6", name: "Pets", owner: "Isabel")
        ]
    }
}
