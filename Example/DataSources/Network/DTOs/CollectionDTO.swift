//
//  CollectionDTO.swift
//  Example
//
//  Created by Tony Martinez on 23/3/22.
//

import Foundation

struct CollectionDTO: DTO {
    let id: String
    let name: String
    let owner: OwnerDTO
}

extension CollectionDTO: DomainConvertible {
    func toDomain() -> Collection {
        Collection(id: id, name: name, owner: owner.firstName)
    }
}
