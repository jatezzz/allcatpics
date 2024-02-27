//
//  ListPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

struct ListPage: View {
    @StateObject var viewModel: ListPageViewModel = DIContainer.shared.resolveListPageViewModel()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("This is a list of out loved cats. Make them yours! Note: The names are auto generated based on the data from the server.")
                    .themedStyle(Theme.TextStyle(font: .footnote, color: .gray))
                    .padding()
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.cats, id: \.id) { cat in
                        NavigationLink(destination: LazyView(DetailPage(catId: cat.id))) {
                            Card(cat: cat)
                                .accessibility(identifier: "catCard_\(cat.id)")
                        }
                        .accessibilityLabel("Cat named \(cat.displayName)")
                        .accessibilityHint("Taps to view more details about this cat.")
                        .accessibility(addTraits: .isButton)
                        .onAppear {
                            if viewModel.shouldLoadMoreData(currentItem: cat) {
                                viewModel.loadNextPage()
                            }
                        }
                    }
                }
                .padding(.horizontal)
                if viewModel.isLoading {
                    ProgressView()
                        .accessibility(identifier: "loadingIndicator")
                        .padding()
                }
            }
            .navigationTitle("Cats")
            .customAlert(item: $viewModel.alertItem)
        }
    }
}

#Preview {
    ListPage()
}
