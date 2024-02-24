//
//  ListPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI
import Kingfisher

class AppViewModel: ObservableObject {
    @Published var isShowingDetailView = false
    @Published var selectedCatId: String?
}

struct NavigationController {
    var appViewModel: AppViewModel
    
    func navigateToDetail(catId: String) {
        appViewModel.selectedCatId = catId
        appViewModel.isShowingDetailView = true
    }
}

struct ListPage: View {
    @StateObject var appViewModel = AppViewModel()
    @ObservedObject var viewModel: ListPageViewModel
    @State var searchText = ""
    
    // Columns definition for the grid
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Search Bar
                TextField("Search Cats", text: $searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .onSubmit {
                        //                        viewModel.searchCats(by: searchText)
                    }
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.cats, id: \.id) { cat in
                        Card(cat: cat)
                        .onTapGesture {
                            NavigationController(appViewModel: appViewModel).navigateToDetail(catId: cat.id)
                        }
                        .onAppear {
                            if viewModel.shouldLoadMoreData(currentItem: cat) {
                                viewModel.loadNextPage()
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Loading More Spinner
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .background(NavigationLink("", destination: DetailPage(viewModel: DetailPageViewModel(repository: viewModel.repository, catId: appViewModel.selectedCatId ?? "")), isActive: $appViewModel.isShowingDetailView))
            .navigationTitle("Cats")
        }
    }
}

#Preview {
    ListPage(viewModel: ListPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage())))
}
