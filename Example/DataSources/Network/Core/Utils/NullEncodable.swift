//
//  NullEncodable.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

@propertyWrapper
struct NullEncodable<T: Encodable>: Encodable {
    var wrappedValue: T?

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch wrappedValue {
        case .some(let value):
            try container.encode(value)
        case .none:
            try container.encodeNil()
        }
    }
}
