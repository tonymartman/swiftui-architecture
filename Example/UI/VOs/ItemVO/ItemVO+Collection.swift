//
//  ItemVO+Collection.swift
//  Example
//
//  Created by Tony Martinez on 21/3/22.
//

import Foundation

extension Collection: ItemVOConvertible {
    func toItemVO() -> ItemVO {
        ItemVO(id: id, leadingText: name, trailingText: owner)
    }
}
