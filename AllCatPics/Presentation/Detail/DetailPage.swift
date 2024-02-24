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
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else if let cat = viewModel.cat {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        let processor = DownsamplingImageProcessor(size: CGSize(width: 400, height: 400))
                        |> RoundCornerImageProcessor(cornerRadius: 4)
                        KFImage(URL(string: "https://cataas.com/cat/\(cat.id)")!)
                            .placeholder { Image(systemName: "cat") }
                            .setProcessor(processor)
                            .loadDiskFileSynchronously()
                            .cacheMemoryOnly()
                            .fade(duration: 0.25)
                            .onProgress { receivedSize, totalSize in  }
                            .onFailure { error in
                                print(error)
                            }
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 400)
                            .frame(maxWidth: .infinity)
                            .accessibilityLabel("Cat image")
                        
                        Text("Name: \(cat.displayName ?? cat.id.generateName())")
                            .themed()
                            .accessibilityLabel("Name \(cat.displayName ?? cat.id.generateName())")
                        
                        Text("Id: \(cat.id)")
                            .themed()
                            .accessibilityLabel("Id \(cat.id)")
                        
                        Text("Tags: \(cat.tags.joined(separator: ", "))")
                            .themed()
                            .accessibilityLabel("Tags: \(cat.tags.joined(separator: ", "))")
                        
                        if let createdAt = cat.createdAt {
                            Text("Created at: \(createdAt)")
                                .themed()
                                .accessibilityLabel("Created at \(createdAt)")
                        }
                        
                        if let updatedAt = cat.updatedDate {
                            Text("Last updated: \(updatedAt)")
                                .themed()
                                .accessibilityLabel("Last updated at \(updatedAt)")
                        }
                        
                        if let size = cat.size {
                            Text("Size: \(size)")
                                .themed()
                                .accessibilityLabel("Size \(size)")
                        }
                        
                        if let mimetype = cat.mimetype {
                            Text("MimeType: \(mimetype)")
                                .themed()
                                .accessibilityLabel("MimeType \(mimetype)")
                        }
                    }
                    .padding()
                }
            } else {
                Text("No details available.")
            }
        }
        .onAppear(perform: viewModel.fetchItemDetail)
        .navigationTitle("Cat Details")
        .environment(\.theme, Theme.defaultTheme) // Apply the theme
        .onAppear(perform: viewModel.fetchItemDetail)
    }
}

#Preview {
    DetailPage(viewModel: DetailPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage()), catId: "abc"))
}
