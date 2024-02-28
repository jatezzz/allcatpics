//
//  KingfisherImageView.swift
//  AllCatPics
//
//  Created by John Trujillo on 25/2/24.
//
import SwiftUI
import Kingfisher

struct CustomCatImageView: View {
    let url: String
    var width: CGFloat?
    var height: CGFloat?
    var contentMode: SwiftUI.ContentMode
    var cornerRadius: CGFloat?
    var onSuccess: () -> Void
    var onFailure: ((Error) -> Void)?

    // State for managing retries
    @State private var attemptCount: Int = 0
    let maxRetryCount: Int = 3
    let retryDelay: TimeInterval = 3.0

    @State private var processor: ImageProcessor

    init(url: String,
         width: CGFloat? = nil,
         height: CGFloat? = nil,
         cornerRadius: CGFloat? = nil,
         contentMode: SwiftUI.ContentMode = .fit,
         onSuccess: @escaping () -> Void = {},
         onFailure: ((Error) -> Void)? = nil) {
        self.url = url
        self.width = width
        self.height = height
        self.contentMode = contentMode
        self.onSuccess = onSuccess
        self.onFailure = onFailure

        let extractedExpr: ImageProcessor
        // Initialize the processor state
        if let cornerRadius {
            extractedExpr = DownsamplingImageProcessor(
                size: CGSize(width: width ?? 400, height: height ?? 400)
            ) |> RoundCornerImageProcessor(
                cornerRadius: cornerRadius
            )
        } else {
            extractedExpr = DownsamplingImageProcessor(size: CGSize(width: width ?? 400, height: height ?? 400))
        }
        _processor = State(initialValue: extractedExpr)
    }

    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                Image(systemName: "cat")
                    .resizable()
                    .tint(Color.white)
                    .padding(40)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.1))
            }
            .setProcessor(processor)
            .resizable()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onSuccess { _ in
                onSuccess()
            }
            .onFailure { error in
                handleFailure(error: error)
            }
            .aspectRatio(contentMode: contentMode)
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius ?? 0)
            .accessibilityLabel("detail.cat.image.accessibilityLabel")
            .accessibilityHint("detail.cat.image.accessibilityHint")
    }

    private func handleFailure(error: KingfisherError) {
        if attemptCount < maxRetryCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + retryDelay) {
                self.attemptCount += 1
                // Trigger a view update by modifying a @State property
                self.processor = self.processor
            }
        } else {
            onFailure?(error)
        }
    }
}

#Preview {
    CustomCatImageView(url: "https://cataas.com/cat/BX0XdDZffs3PqkV7")
}
