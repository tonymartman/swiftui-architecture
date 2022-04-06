//
//  GraphQLErrorItem.swift
//  Example
//
//  Created by Tony Martinez on 4/4/22.
//

import Foundation

struct GraphQLErrorItem {
    let message: String
    let locations: [Location]

    init?(_ value: GraphQLError.JSONObject) {
        guard let message = value[Keys.message.rawValue] as? String,
              let locations = value[Keys.locations.rawValue] as? [GraphQLError.JSONObject] else {
                  return nil
              }

        self.message = message
        self.locations = locations.compactMap(Location.init)
    }
}

private extension GraphQLErrorItem {
    enum Keys: String {
        case message
        case locations
    }
}

extension GraphQLErrorItem {
    struct Location {
        let column: Int
        let line: Int

        init?(_ value: GraphQLError.JSONObject) {
            guard let column = value[Keys.column.rawValue] as? Int,
                  let line = value[Keys.line.rawValue] as? Int else {
                      return nil
                  }

            self.column = column
            self.line = line
        }

        private enum Keys: String {
            case column
            case line
        }
    }
}
