//
//  View+Extension.swift
//  AllCatPics
//
//  Created by John Trujillo on 25/2/24.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
