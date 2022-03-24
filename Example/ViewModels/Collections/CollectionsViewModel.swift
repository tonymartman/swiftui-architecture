// Created for Example in 2022

import Foundation
import SwiftUI
import Resolver

final class CollectionsViewModel: ListViewModelProtocol {
    private var collections = [Collection]() {
        didSet {
            items = collections.map { $0.toItemVO() }
        }
    }

    @Injected private var useCase: FetchAllCollectionsUseCaseProtocol

    @Published private(set) var title: LocalizedStringKey = "My Collections"
    @Published private(set) var state: ListViewModelState = .initial
    @Published private(set) var items = [ItemVO]()
    @Published var showError: Bool = false
    private(set) var error: LocalizedStringKey = ""

    @MainActor func fetchAll(pullRefresh: Bool) async {
        if items.isEmpty && !pullRefresh {
            state = .loading
        }

        defer { state = .loaded }

        do {
            collections = try await useCase.fetchAll()
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    func detailViewModel(item: ItemVO) -> CollectionDetailViewModel {
        guard let index = items.firstIndex(of: item) else {
            fatalError("No detail for item \(item)")
        }

        let collection = Binding<Collection>(
            get: { self.collections[index] },
            set: { self.collections[index] = $0; self.items[index] = $0.toItemVO() }
        )

        return CollectionDetailViewModel(collection: collection)
    }
}
