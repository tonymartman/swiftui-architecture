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
    var delegate: NetworkClientDelegate

    init(host: URL, delegate: NetworkClientDelegate? = nil) {
        self.host = host
        self.session = URLSession(configuration: .default)
        self.delegate = delegate ?? DefaultNetworkClientDelegate()
    }

    func send<T: GraphQLOperation>(_ operation: T) async throws -> T.Response {
        let (data, response) = try await send(operation)
        try validate(response: response, data: data)
        let graphQLResponse = try JSONDecoder().decode(GraphQLResponse<T.Response>.self, from: data)
        return graphQLResponse.dto
    }
}

private extension NetworkClient {
    func send<T: GraphQLOperation>(_ operation: T) async throws -> (Data, URLResponse) {
        do {
            return try await actuallySend(operation)
        } catch {
            guard await delegate.shouldClientRetry(self, withError: error) else { throw error }
            return try await actuallySend(operation)
        }
    }

    func actuallySend<T: GraphQLOperation>(_ operation: T) async throws -> (Data, URLResponse) {
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
