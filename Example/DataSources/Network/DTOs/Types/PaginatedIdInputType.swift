//
//  PaginatedIdInputType.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

struct PaginatedIdInputType: Encodable {
    let id: String
    let page: Int?
    let pageSize: Int?
    @NullEncodable var orderBy: [OrderByInputType]?

    init(id: String, page: Int? = nil, pageSize: Int? = nil, orderBy: [OrderByInputType]? = nil) {
        self.id = id
        self.page = page
        self.pageSize = pageSize
        self.orderBy = orderBy
    }
}
