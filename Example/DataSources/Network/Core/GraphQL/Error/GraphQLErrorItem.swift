//
//  GraphQLErrorItem.swift
//  Example
//
//  Created by Tony Martinez on 4/4/22.
//

import Foundation

struct GraphQLErrorItem: Decodable {
    let message: String
    let locations: [Location]
}

extension GraphQLErrorItem {
    struct Location: Decodable {
        let column: Int
        let line: Int
    }
}
