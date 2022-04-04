//
//  GraphQLError.swift
//  Example
//
//  Created by Tony Martinez on 4/4/22.
//

import Foundation

struct GraphQLError: Error, Decodable {
    let errors: [GraphQLErrorItem]
}
