//
//  MyRequest.swift
//  Example
//
//  Created by Tony Martinez on 23/3/22.
//

import Foundation

struct MyCollectionsOperation: GraphQLOperation {
    typealias Response = [CollectionDTO]

    var query: String {
        """
        query MyCollections {
          myCollections {
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

    var operationName: String {
        "MyCollections"
    }

    var variables: Variables? {
        nil
    }

    var needsAuthorization: Bool { true }

    struct Variables: Encodable {}
}
