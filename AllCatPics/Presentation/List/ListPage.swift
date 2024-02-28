//
//  ListPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

struct ListPage: View {
    @Environment(\.theme) var theme: Theme
    @StateObject var coordinator = DIContainer.shared.coordinator
    @StateObject var viewModel: ListPageViewModel = DIContainer.shared.resolveListPageViewModel()

    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ScrollView {
            Text("list.pageDescription")
                .themedStyle(theme.footnote)
                .padding(.bottom)
                .accessibilityIdentifier("list.page.description")
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
        .navigationTitle("list.page.title")
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
