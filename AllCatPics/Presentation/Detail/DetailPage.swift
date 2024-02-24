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
    @State private var userInputText: String = ""
    
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
                        KFImage(URL(string: viewModel.imageURL)!)
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
                        
                        Text("Make it yours")
                            .themed()
                            .accessibilityLabel("Make it yours")
                        HStack {
                                    TextField("Add text to image", text: $userInputText)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .submitLabel(.done) // Optional: Sets the return key to a "Done" label
                                        .onSubmit {
                                            applyTextAndDismissKeyboard()
                                        }

                                    Button("Apply") {
                                        applyTextAndDismissKeyboard()
                                    }
                                }
                        .padding(.bottom)
                        Button(action: {
                            viewModel.saveImageToGallery()
                        }) {
                            Text("Save Image")
                        }.disabled(viewModel.isSaving)
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        Text("Details")
                            .themed()
                            .accessibilityLabel("Details")
                        if let cat = viewModel.cat, !cat.tags.isEmpty {
                            TagsView(tags: cat.tags)
                                .themed()
                        }
                        
                        
                        Text("Id: \(cat.id)")
                            .themed()
                            .accessibilityLabel("Id \(cat.id)")
                        
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
        .navigationTitle(viewModel.screenTitle)
        .environment(\.theme, Theme.defaultTheme) // Apply the theme
        .onAppear(perform: viewModel.fetchItemDetail)
    }
    
    private func applyTextAndDismissKeyboard() {
          viewModel.applyTextToImage(userInputText)
          dismissKeyboard()
      }
}

#Preview {
    DetailPage(viewModel: DetailPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage()), catId: "abc"))
}

#if canImport(UIKit)
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
