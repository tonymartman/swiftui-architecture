//
//  ItemVO.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

struct ItemVO: VO {
    let id: UUID
    let leadingText: String
    let trailingText: String
}

protocol ItemVOConvertible {
    func toItemVO() -> ItemVO
}
