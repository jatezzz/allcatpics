//
//  AboutView.swift
//  AllCatPics
//
//  Created by John Trujillo on 27/2/24.
//

import Foundation
import SwiftUI

struct AboutView: View {
    @StateObject var coordinator = DIContainer.shared.coordinator
    var body: some View {
        VStack(alignment: .center) {
                Text("about.creator")// "Creator: John Trujillo")
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("about.title")
    }
}
