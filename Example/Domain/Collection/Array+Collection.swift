// Created for Example in 2022

import Foundation

extension Array where Element == Collection {
    func contains(name: String) -> [Collection] {
        filter { $0.name.contains(name) }
    }
}
