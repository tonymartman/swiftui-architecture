// Created for Example in 2022

import Foundation
import Combine
import SwiftUI

final class CollectionsSearchViewModel: SearchViewModelProtocol {
    private var store: [AnyCancellable] = []
    private var currentSearch: Task<Void, Never>?
    private var collections = [Collection]() {
        didSet {
            items = collections.map { $0.toItemVO() }
        }
    }

    @Published var items: [ItemVO] = []
    @Published var searchText: String = ""

    init() {
        observeSearchText()
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

extension CollectionsSearchViewModel {
    private func observeSearchText() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                let text = self.searchText.trimmingCharacters(in: .whitespaces)
                guard !text.isEmpty else { return }

                self.currentSearch = Task { await self.searchCollections(with: text) }
            }
            .store(in: &store)

        $searchText
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .sink { [weak self] text in
                guard let self = self else { return }
                self.currentSearch?.cancel()

                if text.isEmpty {
                    self.items = []
                }
            }
            .store(in: &store)
    }

    @MainActor private func searchCollections(with name: String) async {
        //collections = await Collection.search(name: name)
    }
}
