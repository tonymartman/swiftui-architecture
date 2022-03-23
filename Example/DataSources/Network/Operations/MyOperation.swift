//
//  MyRequest.swift
//  Example
//
//  Created by Tony Martinez on 23/3/22.
//

import Foundation

struct MyOperation: GraphQLOperation {
    typealias Response = CollectionDTO

    let value: String?

    init(value: String?) {
        self.value = value
    }

    var query: String {
        """
        myQuery
        """
    }

    var operationName: String {
        "my operation"
    }

    var variables: Parameters? {
        Parameters(myKey: "my key", otherKey: value)
    }

    var needsAuthorization: Bool { true }

    struct Parameters: Encodable {
        let myKey: String
        let otherKey: String?
    }
}
