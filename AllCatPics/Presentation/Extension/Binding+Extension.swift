//
//  Binding+Extension.swift
//  AllCatPics
//
//  Created by John Trujillo on 24/2/24.
//

import Foundation
import SwiftUI

extension Binding {
    func isNotNil<T>() -> Binding<Bool> where Value == T? {
        .init(get: {
            wrappedValue != nil
        }, set: { _ in
            wrappedValue = nil
        })
    }
}
