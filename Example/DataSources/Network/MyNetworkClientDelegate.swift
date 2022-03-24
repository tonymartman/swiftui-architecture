//
//  MyNetworkClient.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

final class MyNetworkClientDelegate: NetworkClientDelegate {
    func client(_ client: NetworkClient, needsAuthorizationHeaderForRequest request: inout URLRequest) {
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRvbnlAejEuZGlnaXRhbCIsImV4cCI6MTY0Nzk0ODIyMywib3JpZ0lhdCI6MTY0Nzk0NzkyM30.XnjfvF9Vm5JX_TXzKjoCqgdGj6i5BDH9sJguGchyoCk"

        request.addValue("JWT \(token)", forHTTPHeaderField: "Authorization")
    }
}
