//
//  AsyncImageView.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//
import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader = AsyncImageLoader()
    let placeholder: Image
    let url: String
    
    init(url: String, placeholder: Image = Image(systemName: "cat")) {
        self.url = url
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
                    .resizable()
            }
        }
        .onAppear { loader.load(fromURL: url) }
    }
}
