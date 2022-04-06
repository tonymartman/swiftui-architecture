//
//  GraphQLError.swift
//  Example
//
//  Created by Tony Martinez on 4/4/22.
//

import Foundation

struct GraphQLError: Error {
    typealias JSONObject = [String: Any]

    let errors: [GraphQLErrorItem]
    let extensions: JSONObject?

    init?(data: Data) {
        guard let response = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject else {
            return nil
        }

        errors = (response[Keys.errors.rawValue] as? [JSONObject])?.compactMap(GraphQLErrorItem.init) ?? []
        extensions = response[Keys.extensions.rawValue] as? JSONObject
    }
}

private extension GraphQLError {
    enum Keys: String {
        case errors
        case extensions
    }
}
