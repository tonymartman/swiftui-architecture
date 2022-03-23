//
//  VO.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

protocol VO: Identifiable, Equatable {}

extension VO {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
