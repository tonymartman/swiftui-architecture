// Created for Example in 2022

import Foundation
import SwiftUI
import Resolver

final class CollectionDetailViewModel: DetailViewModelProtocol {
    private var collection: Binding<Collection>
    @Injected private var useCase: FetchCollectionUseCaseProtocol

    @Published private(set) var state: DetailViewModelState = .initial
    @Published private(set) var name: String

    init(collection: Binding<Collection>) {
        self.collection = collection
        name = collection.wrappedValue.name
    }

    @MainActor func fetchData() async {
        state = .loading
        defer { state = .loaded }

        do {
            let collection = try await useCase.fetchCollection(id: collection.id)
            update(collection: collection)
        } catch {
            // TODO
            print(error)
        }
    }
}

extension CollectionDetailViewModel {
    private func update(collection: Collection) {
        self.collection.wrappedValue = collection
        name = collection.name
    }
}
