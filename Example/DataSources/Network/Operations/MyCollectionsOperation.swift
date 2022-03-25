//
//  MyRequest.swift
//  Example
//
//  Created by Tony Martinez on 23/3/22.
//

import Foundation

struct MyCollectionsOperation: GraphQLOperation {
    var definition: String {
        """
        query MyCollections {
          myCollections {
            id
            name
            owner {
              ...owner
            }
          }
        }
        """
    }

    var operationName: String { "MyCollections" }
    var needsAuthorization: Bool { true }
    var fragments: [GraphQLFragment] { [ OwnerFragment() ] }
}
