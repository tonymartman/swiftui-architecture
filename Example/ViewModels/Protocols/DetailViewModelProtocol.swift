// Created for Example in 2022

import Foundation

protocol DetailViewModelProtocol: ObservableObject {
    var state: DetailViewModelState { get }
    var name: String { get }

    func fetchData() async
}

enum DetailViewModelState {
    case initial
    case loading
    case loaded
}
