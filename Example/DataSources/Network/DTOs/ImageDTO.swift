//
//  ImageDTO.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

struct ImageDTO: DTO {
    let id: String
    let created: Date
}

extension ImageDTO: DomainConvertible {
    func toDomain() -> Image {
        Image(id: id, created: created)
    }
}
