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
    let applyTextToImage: (String) -> Void
    let saveImageToGallery: () -> Void
    var onSuccess: () -> Void
    var onFailure: ((Error) -> Void)?

    @State private var userInputText: String = ""

    struct CatDetailContentStrings {
        static let tags = LocalizedStringKey("tags")
        static let tagAccessibilityLabel = LocalizedStringKey("tagAccessibilityLabel")
        static let makeItYours = LocalizedStringKey("makeItYours")
        static let details = LocalizedStringKey("details")
        static let applyButton = LocalizedStringKey("detail.applyButton")
        static let applyButtonAccesibilityLabel = LocalizedStringKey("detail.applyButton.accesibilityLabel")
        static let applyButtonAccesibilityHint = LocalizedStringKey("detail.applyButton.accesibilityHint")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .bottomTrailing) {
                KingfisherImageView(
                    url: imageURL,
                    width: nil,
                    height: 400,
                    cornerRadius: 4,
                    onSuccess: onSuccess,
                    onFailure: onFailure
                )
                .frame(maxWidth: .infinity)
                Button(action: {
                    saveImageToGallery()
                }, label: {
                    Image(systemName: "arrow.down.to.line")
                        .resizable()
                        .padding(12)
                        .background(Color.blue)
                        .tint(Color.white)
                        .frame(width: 50, height: 50)
                })
                .disabled(isSaving)
                .clipShape(Circle())
                .shadow(radius: 2)
                .padding(.bottom, 20)
                .padding(.trailing, 10)
                .accessibilityLabel("Download button")
                .accessibilityHint("Taps to download this image.")
                .accessibility(addTraits: .isButton)
            }

            if !cat.tags.isEmpty {
                Text(CatDetailContentStrings.tags)
                    .themedStyle(Theme.TextStyle(font: .caption, color: .secondary))
                    .accessibilityLabel(CatDetailContentStrings.tagAccessibilityLabel)
                TagsView(tags: cat.validTags)
                    .themedStyle(Theme.TextStyle(font: .subheadline, color: .secondary))
            }

            Text(CatDetailContentStrings.makeItYours)
                .themedStyle(Theme.TextStyle(font: .headline, color: .secondary))
                .accessibilityLabel(CatDetailContentStrings.makeItYours)
                .accessibility(identifier: "makeItYours")
            applyTextBar
            Text(CatDetailContentStrings.details)
                .accessibilityLabel(CatDetailContentStrings.details)
                .themedStyle(Theme.TextStyle(font: .headline, color: .secondary))
            detailContent
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }

    private func applyTextAndDismissKeyboard() {
        applyTextToImage(userInputText)
        dismissKeyboard()
    }

    let characterLimit = 40

    var applyTextBar: some View {
        HStack {
            TextField("Add text to image", text: $userInputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .submitLabel(.done)
                .onSubmit {
                    applyTextAndDismissKeyboard()
                }
                .onChange(of: userInputText) { newValue in
                    if newValue.count > characterLimit {
                        userInputText = String(newValue.prefix(characterLimit))
                    }
                }
                .accessibilityLabel("Add text to image")
                .accessibilityHint("Taps to enter a text for the image")

            Button(CatDetailContentStrings.applyButton) {
                applyTextAndDismissKeyboard()
            }
            .accessibilityLabel(CatDetailContentStrings.applyButtonAccesibilityLabel)
            .accessibilityHint(CatDetailContentStrings.applyButtonAccesibilityHint)
            .accessibility(addTraits: .isButton)
        }
        .padding(.bottom)
    }

    var detailContent: some View {
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
    }

}

#Preview {
    CatDetailContent(cat: Cat(
        tags: ["tag1"],
        createdAt: nil,
        updatedAt: nil,
        mimetype: "mimetype",
        size: 1234,
        id: "1234",
        editedAt: nil),
                     imageURL: "imageURL",
                     isSaving: false,
                     applyTextToImage: { _ in
    }, saveImageToGallery: { }, onSuccess: { })
}
