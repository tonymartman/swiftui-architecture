// Created for Example in 2022

import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                //SearchView(viewModel: CollectionsSearchViewModel())
                ListView(viewModel: CollectionsViewModel())
            }
        }
    }
}
