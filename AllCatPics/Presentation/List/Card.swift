//
//  Card.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//
import SwiftUI
import Kingfisher

struct Card: View {
    let cat: Cat
    @Environment(\.theme) var theme: Theme

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width

            VStack {
                ZStack(alignment: .bottomLeading) {
                    CustomCatImageView(
                        url: CatAPIEndpoints.catImageURL(id: cat.id),
                        width: screenWidth,
                        height: screenWidth,
                        cornerRadius: 10,
                        contentMode: .fill
                    )
                    .clipped()
                    .cornerRadius(10)
                    Text(cat.displayName)
                        .bold()
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(5)
                        .padding([.leading, .bottom], 8)
                        .frame(maxWidth: .infinity)
                        .themedStyle(theme.headline)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    Card(cat: Cat(tags: ["tag1"], createdAt: nil, updatedAt: nil, mimetype: nil, size: nil, id: "Hola", editedAt: nil))
}
