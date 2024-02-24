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

struct Card: View {
    let cat: Cat
    
    static let cardHeight: CGFloat = 300
    
    let processor = DownsamplingImageProcessor(size: CGSize(width: Card.cardHeight, height: Card.cardHeight))
    |> RoundCornerImageProcessor(cornerRadius: 10)
    var body: some View {
        VStack {
            KFImage(URL(string: "https://cataas.com/cat/\(cat.id)")!)
                .placeholder { Image(systemName: "cat") }
                .setProcessor(processor)
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onFailure { error in
                    print (error)
                }
                .aspectRatio(contentMode: .fit)
                .frame(height: Card.cardHeight)
                .frame(maxWidth: .infinity)
            
            Text(cat.id)
                .font(.caption)
        }
    }
}

#Preview {
    ListPage(viewModel: ListPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage())))
}
