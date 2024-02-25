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
    @Environment(\.theme) var theme: Theme // Assuming you've set up theming as described earlier

    var body: some View {
        // Calculate half the screen's width minus padding
        let screenWidth = UIScreen.main.bounds.width / 2 - 30
        
        VStack {
            ZStack(alignment: .bottomLeading) {
                KingfisherImageView(url: "https://cataas.com/cat/\(cat.id)", width: screenWidth, height: screenWidth, cornerRadius: 10, contentMode: .fill)

                // Overlay the ID with a semi-transparent background
                Text(cat.displayName)
                    .bold()
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(5)
                    .padding([.leading, .bottom], 8)
                    .frame(maxWidth: .infinity)
            }
            .frame(width: screenWidth, height: screenWidth) // Apply the same frame to ZStack
            .themedStyle(Theme.TextStyle(font: .caption2, color: .red)) // Apply theming if needed, such as for corner radius or shadow
        }
        .frame(width: screenWidth) // Ensure the VStack respects the max width
    }
}

#Preview {
    Card(cat: Cat(tags: ["tag1"], createdAt: nil, updatedAt: nil, mimetype: nil, size: nil, id: "Hola", editedAt: nil))
}
