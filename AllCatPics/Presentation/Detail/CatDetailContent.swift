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
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .bottomTrailing){
                KingfisherImageView(url: imageURL, width: nil, height: 400, cornerRadius: 4)
                    .frame(maxWidth: .infinity)
                Button(action: {
                    saveImageToGallery()
                }) {
                    Image(systemName: "arrow.down.to.line.circle.fill")
                        .resizable()
                        .background(Color.white.opacity(0.9))
                        .tint(Color.black.opacity(0.9))
                        .frame(width: 50, height: 50)
                }.disabled(isSaving)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 10)
                    .padding(.trailing, 10)
            }
            
            
            if !cat.tags.isEmpty {
                Text("Tags:")
                    .themedStyle(Theme.TextStyle(font: .caption, color: .gray))
                    .accessibilityLabel("Tags")
                TagsView(tags: cat.tags)
                    .themedStyle(Theme.TextStyle(font: .subheadline, color: .gray))
            }
            
            Text("Make it yours")
                .themedStyle(Theme.TextStyle(font: .headline, color: .gray))
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
            Text("Details")
                .themedStyle(Theme.TextStyle(font: .headline, color: .gray))
                .accessibilityLabel("Details")
            
            
            Text("Id: \(cat.id)")
                .themedStyle(Theme.TextStyle(font: .body, color: .gray))
                .accessibilityLabel("Id \(cat.id)")
            
            if let createdAt = cat.createdAt {
                Text("Created at: \(createdAt)")
                    .themedStyle(Theme.TextStyle(font: .body, color: .gray))
                    .accessibilityLabel("Created at \(createdAt)")
            }
            
            if let updatedAt = cat.updatedDate {
                Text("Last updated: \(updatedAt)")
                    .themedStyle(Theme.TextStyle(font: .body, color: .gray))
                    .accessibilityLabel("Last updated at \(updatedAt)")
            }
            if let size = cat.size {
                Text("Size: \(size)")
                    .themedStyle(Theme.TextStyle(font: .body, color: .gray))
                    .accessibilityLabel("Size \(size)")
            }
            
            if let mimetype = cat.mimetype {
                Text("MimeType: \(mimetype)")
                    .themedStyle(Theme.TextStyle(font: .body, color: .gray))
                    .accessibilityLabel("MimeType \(mimetype)")
            }
            
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
