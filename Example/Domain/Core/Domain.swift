//
//  Domain.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

protocol Domain: Identifiable, Equatable {}

extension Domain {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

protocol DomainConvertible {
    associatedtype Item: Domain

    func toDomain() -> Item
}
