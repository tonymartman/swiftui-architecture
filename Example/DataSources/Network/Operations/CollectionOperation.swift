//
//  CollectionOperation.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

struct CollectionOperation: GraphQLOperation {
    let id: String

    var definition: String {
        """
        query Collection($id:UUID!) {
          collection(id:$id) {
            id
            name
            owner {
              id
              firstName
            }
          }
        }
        """
    }

    var operationName: String { "Collection" }
    var needsAuthorization: Bool { true }
    var fragments: [GraphQLFragment] { [] }
}
