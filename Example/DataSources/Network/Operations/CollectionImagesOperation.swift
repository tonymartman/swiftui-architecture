//
//  CollectionImagesOperation.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

struct CollectionImagesOperation: GraphQLOperation {
    let input: PaginatedIdInputType

    var definition: String {
        """
        query CollectionImages($input:PaginatedIdInputType!) {
          collectionImages(input: $input) {
            objects {
              id
              created
            }
          }
        }
        """
    }

    var operationName: String { "CollectionImages" }
    var needsAuthorization: Bool { true }
    var fragments: [GraphQLFragment] { [] }
}
