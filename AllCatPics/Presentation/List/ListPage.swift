//
//  ListPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

struct ListPage: View {
    @ObservedObject var viewModel: ListPageViewModel
    
    var body: some View {
        NavigationView {
            List($viewModel.cats) { cat in
                NavigationLink(destination: DetailPage(viewModel: DetailPageViewModel(repository: viewModel.repository, catId: cat.id))) {
                    Text(cat.id)
                }
                .onAppear {
                    if let last = $viewModel.cats.last, cat.id == last.id {
                        viewModel.loadNextPage()
                    }
                }
            }
            .onAppear(perform: viewModel.loadNextPage)
        }
    }
}

#Preview {
    ListPage(viewModel: ListPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage())))
}
