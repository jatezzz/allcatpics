//
//  DetailPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

struct DetailPage: View {
    @StateObject var viewModel: DetailPageViewModel = DIContainer.shared.resolveDetailPageViewModel()
    let catId: String
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .accessibility(identifier: "loadingIndicator")
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else if let cat = viewModel.cat {
                ScrollView {
                    CatDetailContent(cat: cat, imageURL: viewModel.imageURL, isSaving: viewModel.isSaving, handler: { userInputText in
                        viewModel.applyTextToImage(userInputText)
                    }, saveImageToGallery: {
                        viewModel.saveImageToGallery()
                    })
                    
                    .padding()
                }
            } else {
                Text("No details available.")
            }
        }
        .onAppear{viewModel.fetchItemDetail(for: catId)}
        .navigationTitle(viewModel.screenTitle)
        .environment(\.theme, Theme.defaultTheme)
        .customAlert(item: $viewModel.alertItem)
    }
}

#Preview {
    DetailPage(catId: "abc")
}
