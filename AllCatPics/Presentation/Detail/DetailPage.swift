//
//  DetailPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI
import Kingfisher

struct DetailPage: View {
    @ObservedObject var viewModel: DetailPageViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .accessibility(identifier: "loadingIndicator")
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else if let cat = viewModel.cat {
                CatDetailContent(cat: cat, imageURL: viewModel.imageURL, isSaving: viewModel.isSaving, handler: { userInputText in
                    viewModel.applyTextToImage(userInputText)
                }, saveImageToGallery: {
                    viewModel.saveImageToGallery()
                })
            } else {
                Text("No details available.")
            }
        }
        .onAppear(perform: viewModel.fetchItemDetail)
        .navigationTitle(viewModel.screenTitle)
        .environment(\.theme, Theme.defaultTheme)
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

#Preview {
    DetailPage(viewModel: DetailPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage()), catId: "abc"))
}
