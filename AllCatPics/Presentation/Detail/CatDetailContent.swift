//
//  CatDetailContent.swift
//  AllCatPics
//
//  Created by John Trujillo on 25/2/24.
//

import SwiftUI
import Kingfisher

struct CatDetailContent: View {
    let cat: Cat
    let imageURL: String
    let isSaving: Bool
    let handler: (String)->Void
    let saveImageToGallery: ()->Void
    
    @State private var userInputText: String = ""
    var body: some View{
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                let processor = DownsamplingImageProcessor(size: CGSize(width: 400, height: 400))
                |> RoundCornerImageProcessor(cornerRadius: 4)
                KFImage(URL(string: imageURL)!)
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
                    .themedStyle(Theme.TextStyle(font: .largeTitle, color: .blue))
                    .accessibilityLabel("Make it yours")
                    .accessibility(identifier: "searchTextField")
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
                    saveImageToGallery()
                }) {
                    Text("Save Image")
                }.disabled(isSaving)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                Text("Details")
                    .themedStyle(Theme.TextStyle(font: .subheadline, color: .gray))
                    .accessibilityLabel("Details")
                if !cat.tags.isEmpty {
                    TagsView(tags: cat.tags)
                        .themedStyle(Theme.TextStyle(font: .subheadline, color: .gray))
                }
                
                
                Text("Id: \(cat.id)")
                    .themedStyle(Theme.TextStyle(font: .subheadline, color: .gray))
                    .accessibilityLabel("Id \(cat.id)")
                
                if let createdAt = cat.createdAt {
                    Text("Created at: \(createdAt)")
                        .themedStyle(Theme.TextStyle(font: .subheadline, color: .gray))
                        .accessibilityLabel("Created at \(createdAt)")
                }
                
                if let updatedAt = cat.updatedDate {
                    Text("Last updated: \(updatedAt)")
                        .themedStyle(Theme.TextStyle(font: .subheadline, color: .gray))
                        .accessibilityLabel("Last updated at \(updatedAt)")
                }
                if let size = cat.size {
                    Text("Size: \(size)")
                        .themedStyle(Theme.TextStyle(font: .subheadline, color: .gray))
                        .accessibilityLabel("Size \(size)")
                }
                
                if let mimetype = cat.mimetype {
                    Text("MimeType: \(mimetype)")
                        .themedStyle(Theme.TextStyle(font: .subheadline, color: .gray))
                        .accessibilityLabel("MimeType \(mimetype)")
                }
                
            }
            .padding()
        }
    }
    
    private func applyTextAndDismissKeyboard() {
        handler(userInputText)
        dismissKeyboard()
    }
}

#Preview {
    CatDetailContent(cat: Cat(tags: ["tag1"], createdAt: nil, updatedAt: nil, mimetype: nil, size: nil, id: "1234", editedAt: nil), imageURL: "imageURL", isSaving: false, handler: { _ in
    }, saveImageToGallery: {    })
}
