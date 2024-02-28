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
    var title: LocalizedStringKey = LocalizedStringKey("alertItem.title")
    var message: LocalizedStringKey  = LocalizedStringKey("alertItem.message")
    let dismissButtonText: LocalizedStringKey = LocalizedStringKey("alertItem.dismissButtonText")
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
