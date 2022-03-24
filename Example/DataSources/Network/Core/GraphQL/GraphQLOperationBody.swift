//
//  GraphQLRequestBody.swift
//  Example
//
//  Created by Tony Martinez on 23/3/22.
//

import Foundation

struct GraphQLOperationBody<T: Encodable>: Encodable {
    let query: String
    let operationName: String
    @NullEncodable var variables: T?
}
