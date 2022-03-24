//
//  DateFormatter+iso8601.swift
//  Example
//
//  Created by Tony Martinez on 24/3/22.
//

import Foundation

extension DateFormatter {
    static let formatter8601: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter
    }()
}
