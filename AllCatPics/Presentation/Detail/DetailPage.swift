//
//  DetailPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI


struct DetailPage: View {
    @ObservedObject var viewModel: DetailPageViewModel
    
    var body: some View {
        VStack {
            if let cat = viewModel.cat {
                Text(cat.id).font(.title)
                Text(cat.tags.map({$0}).joined(separator: "-")).font(.body)
            }
        }
        .onAppear(perform: viewModel.fetchItemDetail)
    }
}

#Preview {
    DetailPage(viewModel: DetailPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage()), catId: "abc"))
}
