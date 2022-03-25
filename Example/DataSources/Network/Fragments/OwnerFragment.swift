//
//  OwnerFragment.swift
//  Example
//
//  Created by Tony Martinez on 25/3/22.
//

import Foundation

struct OwnerFragment: GraphQLFragment {
    var definition: String {
        """
        fragment owner on UserType {
            id
            firstName
        }
        """
    }
}
