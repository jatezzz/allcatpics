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
                KFImage(URL(string: "https://cataas.com/cat/\(cat.id)")!)
                    .placeholder { Image(systemName: "cat") }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth, height: screenWidth) // Force image to be a square with width half of the screen
                    .clipped()
                    .cornerRadius(10)

                // Overlay the ID with a semi-transparent background
                Text(cat.displayName ?? cat.id)
                    .bold()
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(5)
                    .padding([.leading, .bottom], 8)
                    .frame(maxWidth: .infinity)
            }
            .frame(width: screenWidth, height: screenWidth) // Apply the same frame to ZStack
            .themed() // Apply theming if needed, such as for corner radius or shadow
        }
        .frame(width: screenWidth) // Ensure the VStack respects the max width
    }
}
