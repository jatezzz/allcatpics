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
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.cats, id: \.id) { cat in
                        NavigationLink(destination: LazyView(DetailPage(viewModel: DIContainer.shared.resolveDetailPageViewModel(catId: cat.id)))) {
                            Card(cat: cat)
                                .accessibility(identifier: "catCard_\(cat.id)")
                        }
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
            .alert(
                "Oops! Something went wrong...",
                isPresented: $viewModel.error.isNotNil(),
                presenting: viewModel.error,
                actions: { _ in },
                message: { error in
                    Text("There's been an error")
                }
            )
        }
    }
}

#Preview {
    ListPage()
}
