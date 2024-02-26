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
        let screenWidth = UIScreen.main.bounds.width / 2 - 30
        
        VStack {
            ZStack(alignment: .bottomLeading) {
                KingfisherImageView(url: CatAPIEndpoints.catImageURL(id: cat.id), width: screenWidth, height: screenWidth, cornerRadius: 10, contentMode: .fill)
                Text(cat.displayName)
                    .bold()
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(5)
                    .padding([.leading, .bottom], 8)
                    .frame(maxWidth: .infinity)
            }
            .frame(width: screenWidth, height: screenWidth)
            .themedStyle(Theme.TextStyle(font: .headline, color: .black))
        }
        .frame(width: screenWidth)
    }
}

#Preview {
    Card(cat: Cat(tags: ["tag1"], createdAt: nil, updatedAt: nil, mimetype: nil, size: nil, id: "Hola", editedAt: nil))
}
