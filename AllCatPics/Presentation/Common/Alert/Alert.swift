//
//  Alert.swift
//  AllCatPics
//
//  Created by John Trujillo on 26/2/24.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: String = "Oops! Something went wrong..."
    var message: String  = "There's been an error"
    let dismissButtonText: String = "OK"
}

extension View {
    func customAlert(item: Binding<AlertItem?>) -> some View {
        self.alert(item: item) { alertItem in
            Alert(
                title: Text(alertItem.title),
                message: Text(alertItem.message),
                dismissButton: .default(Text(alertItem.dismissButtonText))
            )
        }
    }
}
