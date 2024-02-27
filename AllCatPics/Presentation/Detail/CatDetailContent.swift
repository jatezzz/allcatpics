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
                    Image(systemName: "arrow.down.to.line")
                        .resizable()
                        .padding(12)
                        .background(Color.blue)
                        .tint(Color.white)
                        .frame(width: 50, height: 50)
                }
                .disabled(isSaving)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(radius: 2)
                .padding(.bottom, 20)
                .padding(.trailing, 10)
                .accessibilityLabel("Download button")
                .accessibilityHint("Taps to download this image.")
                .accessibility(addTraits: .isButton)
            }
            
            
            if !cat.tags.isEmpty {
                Text("Tags:")
                    .themedStyle(Theme.TextStyle(font: .caption, color: .gray))
                    .accessibilityLabel("Tags")
                TagsView(tags: cat.tags)
                    .themedStyle(Theme.TextStyle(font: .subheadline, color: .black))
            }
            
            Text("Make it yours")
                .themedStyle(Theme.TextStyle(font: .headline, color: .black))
                .accessibilityLabel("Make it yours")
                .accessibility(identifier: "makeItYours")
            HStack {
                TextField("Add text to image", text: $userInputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.done)
                    .onSubmit {
                        applyTextAndDismissKeyboard()
                    }
                    .accessibilityLabel("Add text to image")
                    .accessibilityHint("Taps to enter a text for the image")
                
                Button("Apply") {
                    applyTextAndDismissKeyboard()
                }
                .accessibilityLabel("Apply text button")
                .accessibilityHint("Taps to aply a the text to the image.")
                .accessibility(addTraits: .isButton)
            }
            .padding(.bottom)
            Text("Details")
                .accessibilityLabel("Details")
                .themedStyle(Theme.TextStyle(font: .headline, color: .black))
            
            VStack(alignment: .leading) {
                Text("Id: \(cat.id)")
                    .accessibilityLabel("Id \(cat.id)")
            
                if let createdAt = cat.createdAt?.formatDateString(), !createdAt.isEmpty {
                    Text("Created at: \(createdAt)")
                        .accessibilityLabel("Created at \(createdAt)")
                }
                
                if let updatedAt = cat.updatedDate?.formatDateString(), !updatedAt.isEmpty {
                    Text("Last updated: \(updatedAt)")
                        .accessibilityLabel("Last updated at \(updatedAt)")
                }
                if let size = cat.size {
                    Text("Size: \(size)")
                        .accessibilityLabel("Size \(size)")
                }
                
                if let mimetype = cat.mimetype {
                    Text("MimeType: \(mimetype)")
                        .accessibilityLabel("MimeType \(mimetype)")
                }
            }
            .themedStyle(Theme.TextStyle(font: .body, color: .secondary))
            .frame(maxWidth:.infinity, alignment:.topLeading)
          
            
            
          
            
            
         
            
        }
    }
    
    private func applyTextAndDismissKeyboard() {
        handler(userInputText)
        dismissKeyboard()
    }
    

}

#Preview {
    CatDetailContent(cat: Cat(tags: ["tag1"], createdAt: nil, updatedAt: nil, mimetype: "mimetype", size: 1234, id: "1234", editedAt: nil), imageURL: "imageURL", isSaving: false, handler: { _ in
    }, saveImageToGallery: {    })
}
