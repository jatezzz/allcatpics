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

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .bottomTrailing) {
                CustomCatImageView(
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
                .accessibilityIdentifier("detail.downloadButton")
                .accessibilityLabel("detail.downloadButton.accessibilityLabel")
                .accessibilityHint("detail.downloadButton.accessibilityHint")
                .accessibility(addTraits: .isButton)
            }

            if !cat.tags.isEmpty {
                Text("detail.tags")
                    .themedStyle(Theme.TextStyle(font: .caption, color: .secondary))
                    .accessibilityLabel("detail.tag.AccessibilityLabel")
                TagsView(tags: cat.validTags)
                    .themedStyle(Theme.TextStyle(font: .subheadline, color: .primary))
            }

            Text("detail.makeItYours")
                .themedStyle(Theme.TextStyle(font: .headline, color: .secondary))
                .accessibilityLabel("detail.makeItYours")
                .accessibility(identifier: "detail.makeItYours.accessibilityLabel")
            applyTextBar
            Text("details")
                .accessibilityLabel("details")
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
            TextField("detail.addTextToImage", text: $userInputText)
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
                .accessibilityLabel("detail.addTextToImage.accessibilityLabel")
                .accessibilityHint("detail.addTextToImage.accessibilityHint")
                .accessibilityIdentifier("detail.addTextToImage")

            Button("detail.applyButton") {
                applyTextAndDismissKeyboard()
            }
            .accessibilityLabel("detail.applyButton.accesibilityLabel")
            .accessibilityHint("detail.applyButton.accesibilityHint")
            .accessibilityIdentifier("detail.applyButton")
            .accessibility(addTraits: .isButton)
        }
        .padding(.bottom)
    }

    var detailContent: some View {
        VStack(alignment: .leading) {
            Text("detail.id.\(cat.id)")
                .accessibilityLabel("detail.id.accessibilityLabel\(cat.id)")
                .accessibilityIdentifier("detail.id")

            if let createdAt = cat.createdAt?.formatDateString(), !createdAt.isEmpty {
                Text("detail.createdAt.\(createdAt)")
                    .accessibilityLabel("detail.createdAt.accessibilityLabel.\(createdAt)")
            }

            if let updatedAt = cat.updatedDate?.formatDateString(), !updatedAt.isEmpty {
                Text("detail.lastUpdateAt.\(updatedAt)")
                    .accessibilityLabel("detail.lastUpdateAt.accessibilityLabel\(updatedAt)")
            }
            if let size = cat.size {
                Text("detail.size.\(size)")
                    .accessibilityLabel("detail.size.accessibilityLabel.\(size)")
            }

            if let mimetype = cat.mimetype {
                Text("detail.mimetype.\(mimetype)")
                    .accessibilityLabel("detail.mimetype.accessibilityLabel.\(mimetype)")
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
