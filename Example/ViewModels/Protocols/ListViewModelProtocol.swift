// Created for Example in 2022

import Foundation
import SwiftUI

protocol ListViewModelProtocol: ObservableObject {
    associatedtype DetailViewModel: DetailViewModelProtocol

    var title: LocalizedStringKey { get }
    var state: ListViewModelState { get }
    var items: [ItemVO] { get set }

    func fetchAll(pullRefresh: Bool) async
    func detailViewModel(item: ItemVO) -> DetailViewModel
}

enum ListViewModelState {
    case initial
    case loading
    case loaded
    case error(LocalizedStringKey)
}
