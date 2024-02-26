//
//  TagsView.swift
//  AllCatPics
//
//  Created by John Trujillo on 24/2/24.
//

import SwiftUI

struct TagsView: View {
    let tags: [String]
    private let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(tags.indices, id: \.self) { index in
                    Text(tags[index])
                        .padding(.vertical, 8)
                        .padding(.horizontal, 14)
                        .background(colors[index % colors.count])
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .accessibilityLabel("\(tags[index]) tag")
                }
            }
        }
    }
}
