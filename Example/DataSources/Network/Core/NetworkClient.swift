//
//  NetworkClient.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

final class NetworkClient {
    let host: URL
    let session: URLSession
    let decoder: JSONDecoder
    var delegate: NetworkClientDelegate

    init(host: URL,
         decoder: JSONDecoder = JSONDecoder(),
         delegate: NetworkClientDelegate = DefaultNetworkClientDelegate()) {
        self.host = host
        self.session = URLSession(configuration: .default)
        self.decoder = decoder
        self.delegate = delegate
    }

    func send<T: Decodable>(_ operation: GraphQLOperation) async throws -> T {
        let (data, response) = try await send(operation)
        try validate(response: response, data: data)
        return try decoder.decode(GraphQLResponse<T>.self, from: data).decodedValue
    }

    func send(_ operation: GraphQLOperation) async throws {
        let (data, response) = try await send(operation)
        try validate(response: response, data: data)
    }
}

private extension NetworkClient {
    func send(_ operation: GraphQLOperation) async throws -> (Data, URLResponse) {
        do {
            return try await actuallySend(operation)
        } catch {
            guard await delegate.shouldClientRetry(self, withError: error) else { throw error }
            return try await actuallySend(operation)
        }
    }

    func actuallySend(_ operation: GraphQLOperation) async throws -> (Data, URLResponse) {
        var request = try operation.toURLRequest(host)
        if operation.needsAuthorization {
            delegate.client(self, needsAuthorizationHeaderForRequest: &request)
        }

        return try await session.data(for: request, delegate: nil)
    }

    func validate(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        if !(200..<300).contains(httpResponse.statusCode) {
            throw delegate.client(self, didReceiveInvalidResponse: httpResponse, data: data)
        }
    }
}

protocol NetworkClientDelegate {
    func client(_ client: NetworkClient, willSendRequest request: inout URLRequest)
    func shouldClientRetry(_ client: NetworkClient, withError: Error) async -> Bool
    func client(_ client: NetworkClient, didReceiveInvalidResponse response: HTTPURLResponse, data: Data) -> Error
    func client(_ client: NetworkClient, needsAuthorizationHeaderForRequest request: inout URLRequest)
}

extension NetworkClientDelegate {
    func client(_ client: NetworkClient, willSendRequest request: inout URLRequest) {}
    func shouldClientRetry(_ client: NetworkClient, withError: Error) async -> Bool { false }
    func client(_ client: NetworkClient, didReceiveInvalidResponse response: HTTPURLResponse, data: Data) -> Error {
        URLError(.unknown)
    }
    func client(_ client: NetworkClient, needsAuthorizationHeaderForRequest request: inout URLRequest) {}
}

private class DefaultNetworkClientDelegate: NetworkClientDelegate {}
