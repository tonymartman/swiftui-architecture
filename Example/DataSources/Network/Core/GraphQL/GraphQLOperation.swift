//
//  GraphQLRequest.swift
//  Example
//
//  Created by Tony Martinez on 23/3/22.
//

import Foundation

protocol GraphQLOperation {
    associatedtype Variables: Encodable
    associatedtype Response: DTO

    var query: String { get }
    var operationName: String { get }
    var variables: Variables? { get }
    var needsAuthorization: Bool { get }
}

extension GraphQLOperation {
    func toURLRequest(_ host: URL) throws -> URLRequest {
        var request = URLRequest(url: host)
        request.httpMethod = "POST"

        let body = GraphQLOperationBody(query: query,
                                        operationName: operationName,
                                        variables: variables)

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
            "Content-Type": "application/graphql",
            "Accept": "application/json"
        ]
    }
}
