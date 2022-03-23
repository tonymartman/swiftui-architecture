// Created for Example in 2022

import SwiftUI

struct ListView<ViewModel: ListViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        contentView
            .task {
                if case .initial = viewModel.state {
                    await viewModel.fetchAll(pullRefresh: false)
                }
            }
            .navigationTitle(viewModel.title)
    }
}

// MARK: - Layouts

extension ListView {
    @ViewBuilder private var contentView: some View {
        switch viewModel.state {
        case .initial, .loaded:
            list
                .alert(viewModel.error, isPresented: $viewModel.showError) {
                    Button("OK", role: .cancel) {}
                }
        case .loading:
            ProgressView()
        }
    }

    private var list: some View {
        List(viewModel.items) {
            itemView($0)
        }
        .refreshable { await viewModel.fetchAll(pullRefresh: true) }
    }

    func itemView(_ item: ItemVO) -> some View {
        NavigationLink {
            let viewModel = viewModel.detailViewModel(item: item)
            DetailView(viewModel: viewModel)
        } label: {
            LeadingTrailingCell(itemVO: item)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CollectionsViewModel()

        NavigationView {
            ListView(viewModel: viewModel)
        }
        .previewDevice("iPhone 13")
    }
}
