//
//  ListPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

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
    
    var body: some View {
        NavigationView {
            List($viewModel.cats) { cat in
                Button(action: {
                    NavigationController(appViewModel: appViewModel).navigateToDetail(catId: cat.id)
                }){HStack{
                    AsyncImageView(url: "https://cataas.com/cat/\(cat.id)")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
                    Text(cat.id)
                }
                .onAppear {
                    if let last = $viewModel.cats.last, cat.id == last.id {
                        viewModel.loadNextPage()
                    }
                }
            }
            .background(NavigationLink("", destination: DetailPage(viewModel: DetailPageViewModel(repository: viewModel.repository, catId: appViewModel.selectedCatId ?? "")), isActive: $appViewModel.isShowingDetailView))
        }
    }
}

#Preview {
    ListPage(viewModel: ListPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage())))
}
