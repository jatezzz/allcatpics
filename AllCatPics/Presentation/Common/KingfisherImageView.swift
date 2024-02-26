//
//  KingfisherImageView.swift
//  AllCatPics
//
//  Created by John Trujillo on 25/2/24.
//

import SwiftUI
import Kingfisher

struct KingfisherImageView: View {
    let url: String
    var processor: ImageProcessor
    var width: CGFloat?
    var height: CGFloat?
    var contentMode: SwiftUI.ContentMode
    var cornerRadius: CGFloat?
    
    init(url: String, width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: CGFloat? = nil, contentMode: SwiftUI.ContentMode = .fit) {
        self.url = url
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.contentMode = contentMode
        
        if let cornerRadius {
            self.processor =  DownsamplingImageProcessor(size: CGSize(width: width ?? 400, height: height ?? 400)) |> RoundCornerImageProcessor(cornerRadius: cornerRadius)
        } else {
            self.processor =  DownsamplingImageProcessor(size: CGSize(width: width ?? 400, height: height ?? 400))
        }
    }
    
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                Image(systemName: "cat")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .clipped()
                    .cornerRadius(cornerRadius ?? 0)
            }
            .setProcessor(processor)
            .resizable()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { _, _ in }
            .onFailure { error in print(error) }
            .aspectRatio(contentMode: contentMode)
            .frame(width: width, height: height)
            .clipped()
            .cornerRadius(cornerRadius ?? 0)
            .accessibilityLabel("Cat image")
    }
}


#Preview {
    KingfisherImageView(url: "https://cataas.com/cat/BX0XdDZffs3PqkV7")
}
