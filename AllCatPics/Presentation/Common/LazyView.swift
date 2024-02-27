//
//  LazyView.swift
//  AllCatPics
//
//  Created by John Trujillo on 27/2/24.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}
