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
            }
            .onAppear(perform: viewModel.fetchItems)
        }
    }
}

#Preview {
    ListPage(viewModel: ListPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage())))
}
