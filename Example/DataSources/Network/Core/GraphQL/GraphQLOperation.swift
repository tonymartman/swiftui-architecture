//
//  GraphQLRequest.swift
//  Example
//
//  Created by Tony Martinez on 23/3/22.
//

import Foundation

struct EmptyVariables: Encodable {}

protocol GraphQLOperation: Encodable {
    var query: String { get }
    var operationName: String { get }
    var needsAuthorization: Bool { get }
    var fragments: [GraphQLFragment] { get }
}

extension GraphQLOperation {
    func toURLRequest(_ host: URL) throws -> URLRequest {
        var request = URLRequest(url: host)
        request.httpMethod = "POST"

        let body = GraphQLOperationBody(query: fragments.reduce(query) { $0.appending("\n" + $1.definition) },
                                        operationName: operationName,
                                        variables: self)

        request.httpBody = try JSONEncoder().encode(body)
        additionalHeaders().forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}

private extension GraphQLOperation {
    func additionalHeaders() -> [String: String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
