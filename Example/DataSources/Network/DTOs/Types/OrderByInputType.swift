//
//  OrderByInputType.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

struct OrderByInputType: Encodable {
    @NullEncodable var field: String?
    @NullEncodable var ordering: String?
}
