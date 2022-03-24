//
//  JSONDecoder+GraphQL.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

extension JSONDecoder {
    static let graphQL: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.formatter8601)
        return decoder
    }()
}
