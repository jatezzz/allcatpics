//
//  ListPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

struct ListPage: View {
    @StateObject var coordinator = DIContainer.shared.coordinator

    @StateObject var viewModel: ListPageViewModel = DIContainer.shared.resolveListPageViewModel()

    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ScrollView {
            Text("list.pageDescription")
                .themedStyle(Theme.TextStyle(font: .footnote, color: .gray))
                .padding()
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cats, id: \.id) { cat in
                    Card(cat: cat)
                        .onTapGesture {
                            coordinator.navigate(to: .detail(cat: cat))
                        }
                        .accessibility(identifier: "catCard_\(cat.id)")
                        .accessibilityLabel("list.cat.name.accessibilityLabel.\(cat.displayName)")
                        .accessibilityHint("list.cat.name.accessibilityHint")
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
        .navigationTitle("listPageScreenTitle")
        .customAlert(item: $viewModel.alertItem)
    }
}

 #Preview {
    ListPage()
         .environment(\.locale, .init(identifier: "es"))
 }

 #Preview {
    ListPage()
 }
