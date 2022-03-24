//
//  CollectionOperation.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

struct CollectionOperation: GraphQLOperation {
    let id: String

    var query: String {
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
}