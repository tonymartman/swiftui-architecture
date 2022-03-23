// Created for Example in 2022

import Foundation
import SwiftUI

final class CollectionDetailViewModel: DetailViewModelProtocol {
    private var collection: Binding<Collection>
    @Published private(set) var state: DetailViewModelState = .initial
    @Published private(set) var name: String


    init(collection: Binding<Collection>) {
        self.collection = collection
        name = collection.wrappedValue.name
    }

    @MainActor func fetchData() async {
        state = .loading
        defer { state = .loaded }

        let collection = await Collection.fetch(id: collection.id)
        update(collection: collection)
    }
}

extension CollectionDetailViewModel {
    private func update(collection: Collection) {
        self.collection.wrappedValue = collection
        name = collection.name
    }
}
