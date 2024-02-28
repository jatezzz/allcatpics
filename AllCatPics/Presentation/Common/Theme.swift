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
    var secondaryTextColor: Color

    struct TextStyle {
        var font: Font
        var color: Color
    }

    var bodyStyle: TextStyle
    var captionStyle: TextStyle
    var subheadline: TextStyle
    var headline: TextStyle
    var footnote: TextStyle

    static let lightTheme = Theme(
        accentColor: .orange,
        primaryTextColor: .white,
        secondaryTextColor: .secondary,
        bodyStyle: TextStyle(font: .body, color: .gray),
        captionStyle: TextStyle(font: .caption, color: .gray),
        subheadline: TextStyle(font: .subheadline.bold(), color: .black),
        headline: TextStyle(font: .headline.weight(.heavy), color: .black),
        footnote: TextStyle(font: .footnote, color: .gray)
    )

    static let darkTheme = Theme(
        accentColor: .orange,
        primaryTextColor: .white,
        secondaryTextColor: .secondary,
        bodyStyle: TextStyle(font: .body, color: .gray),
        captionStyle: TextStyle(font: .caption, color: .gray),
        subheadline: TextStyle(font: .subheadline.bold(), color: .white),
        headline: TextStyle(font: .headline.weight(.heavy), color: .white),
        footnote: TextStyle(font: .footnote, color: .gray)
    )
}

private struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .lightTheme
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

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
