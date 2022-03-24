//
//  GraphQLResponse.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

struct GraphQLResponse<T: Decodable>: Decodable {
    let decodedValue: T

    private struct DynamicKey: CodingKey {
        var stringValue: String

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) { nil }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        guard let dataKey = container.allKeys.first else { throw GraphQLResponseDecodingError.dataKeyNotFound }

        let dataContainer = try container.nestedContainer(keyedBy: DynamicKey.self, forKey: dataKey)

        guard let operationKey = dataContainer.allKeys.first else { throw GraphQLResponseDecodingError.operationKeyNotFound }
        decodedValue = try dataContainer.decode(T.self, forKey: operationKey)
    }
}

enum GraphQLResponseDecodingError: Error {
    case dataKeyNotFound
    case operationKeyNotFound
}
