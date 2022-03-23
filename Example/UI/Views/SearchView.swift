// Created for Example in 2022

import SwiftUI

struct SearchView<T: SearchViewModelProtocol>: View {
    @StateObject var viewModel: T

    var body: some View {
        List(viewModel.items) {
            itemView($0)
        }
        .searchable(text: $viewModel.searchText)
    }
}

// MARK: - Layouts

extension SearchView {
    private func itemView(_ item: ItemVO) -> some View {
        NavigationLink {
            let viewModel = viewModel.detailViewModel(item: item)
            DetailView(viewModel: viewModel)
        } label: {
            LeadingTrailingCell(itemVO: item)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CollectionsSearchViewModel()

        NavigationView {
            SearchView(viewModel: viewModel)
        }
        .previewDevice("iPhone 13")
    }
}
