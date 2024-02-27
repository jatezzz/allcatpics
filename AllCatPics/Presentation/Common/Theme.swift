//
//  Theme.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation
import SwiftUI

struct Theme {
    var accentColor: Color
       var primaryTextColor: Color
       var secondaryTextColor: Color // Add a secondary text color for variety

       struct TextStyle {
           var font: Font
           var color: Color
       }

       var bodyStyle: TextStyle
       var captionStyle: TextStyle

       static let defaultTheme = Theme(
           accentColor: .blue,
           primaryTextColor: .primary,
           secondaryTextColor: .secondary,
           bodyStyle: TextStyle(font: .body, color: .primary),
           captionStyle: TextStyle(font: .caption, color: .secondary)
       )
}

// Define a custom environment key for the theme
private struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .defaultTheme
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

//// A custom view modifier to apply the theme
// struct ThemedModifier: ViewModifier {
//    @Environment(\.theme) var theme: Theme
//    
//    func body(content: Content) -> some View {
//        content
//            .foregroundColor(theme.textColor)
//            .font(theme.fontSize)
//    }
// }

struct ThemedStyleModifier: ViewModifier {
    var style: Theme.TextStyle

    func body(content: Content) -> some View {
        content
            .foregroundColor(style.color)
            .font(style.font)
    }
}

extension View {
    func themedStyle(_ style: Theme.TextStyle ) -> some View {
        self.modifier(ThemedStyleModifier(style: style))
    }
}
