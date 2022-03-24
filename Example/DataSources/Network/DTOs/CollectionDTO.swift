//
//  CollectionDTO.swift
//  Example
//
//  Created by Tony Martinez on 23/3/22.
//

import Foundation

struct OwnerDTO: DTO {
    let id: String
    let firstName: String
}

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
