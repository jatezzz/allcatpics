//
//  DetailPage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

struct DetailPage: View {
    @StateObject var coordinator = DIContainer.shared.coordinator
    @StateObject var viewModel: DetailPageViewModel = DIContainer.shared.resolveDetailPageViewModel()
    @Environment(\.theme) var theme: Theme

    let catId: String

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .accessibility(identifier: "loadingIndicator")
            } else if viewModel.error != nil {
                Text("general.error")
            } else if let cat = viewModel.cat {
                ScrollView {
                    Text(LocalizedStringKey("detail.page.description"))
                        .themedStyle(theme.footnote)
                        .accessibilityIdentifier("detail.page.description")
                        .padding(.leading)
                        .padding(.trailing)
                    CatDetailContent(
                        cat: cat,
                        imageURL: viewModel.imageURL,
                        isSaving: viewModel.isSaving,
                        applyTextToImage: { userInputText in
                            viewModel.applyTextToImage(userInputText)
                        }, saveImageToGallery: {
                            viewModel.saveImageToGallery()
                        }, onSuccess: {

                        }, onFailure: { _ in
                            viewModel.onImageFailure()
                        })
                    .padding()
                }
            } else {
                Text("detail.no.details")
            }
        }
        .onAppear {viewModel.fetchItemDetail(for: catId)}
        .navigationTitle(viewModel.screenTitle)
        .customAlert(item: $viewModel.alertItem)
    }
}

#Preview {
    DetailPage(catId: "abc")
}
