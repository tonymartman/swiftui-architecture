// Created for Example in 2022

import Foundation

protocol SearchViewModelProtocol: ObservableObject {
    associatedtype DetailViewModel: DetailViewModelProtocol
    
    var items: [ItemVO] { get set }
    var searchText: String { get set }

    func detailViewModel(item: ItemVO) -> DetailViewModel
}
