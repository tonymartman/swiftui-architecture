// Created for Example in 2022

import SwiftUI

struct DetailView<T: DetailViewModelProtocol>: View {
    @StateObject var viewModel: T

    var body: some View {
        Text(viewModel.name)
            .task { await viewModel.fetchData() }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let collection = Collection.mock()
        let viewModel = CollectionDetailViewModel(collection: .constant(collection))
        
        NavigationView {
            DetailView(viewModel: viewModel)
        }
        .previewDevice("iPhone 13")
    }
}
