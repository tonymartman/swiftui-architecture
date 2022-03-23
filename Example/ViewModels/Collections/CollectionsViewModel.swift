// Created for Example in 2022

import Foundation
import SwiftUI

final class CollectionsViewModel: ListViewModelProtocol {
    private var collections = [Collection]() {
        didSet {
            items = collections.map { $0.toItemVO() }
        }
    }

    private let useCase: FetchAllCollectionsUseCaseProtocol

    @Published var title: LocalizedStringKey = "My Collections"
    @Published var state: ListViewModelState = .initial
    @Published var items = [ItemVO]()

    init(useCase: FetchAllCollectionsUseCaseProtocol) {
        self.useCase = useCase
    }

    @MainActor func fetchAll(pullRefresh: Bool) async {
        if items.isEmpty && !pullRefresh {
            state = .loading
        }

        do {
            collections = try await useCase.fetchAll()
            state = .loaded
        } catch FetchAllCollectionsError.error1 {
            state = .error("my first error")
        } catch FetchAllCollectionsError.error2 {
            state = .error("my second error")
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
