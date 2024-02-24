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
    var textColor: Color
    var fontSize: Font
    
    static let defaultTheme = Theme(accentColor: .blue, textColor: .primary, fontSize: .body)
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

// A custom view modifier to apply the theme
struct ThemedModifier: ViewModifier {
    @Environment(\.theme) var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(theme.textColor)
            .font(theme.fontSize)
    }
}

extension View {
    func themed() -> some View {
        self.modifier(ThemedModifier())
    }
}
