//
//  ContentView.swift
//  AllCatPics
//
//  Created by John Trujillo on 27/2/24.
//

import Foundation
import SwiftUI
struct ContentView: View {
    @StateObject var coordinator = NavigationCoordinator()

    var body: some View {
        NavigationView {
            currentView
                .navigationBarTitle("Cats", displayMode: .automatic)
                .navigationBarItems(leading: backButton, trailing: aboutButton)
        }
    }

    @ViewBuilder
    private var currentView: some View {
        switch coordinator.navigationStack.last {
        case .root:
            ListPage(coordinator: coordinator)
        case .detail(let cat):
            DetailPage(coordinator: coordinator, catId: cat.id)
        case .about:
            AboutView(coordinator: coordinator)
        default:
            Text("Not Implemented")
        }
    }

    private var backButton: some View {
        Button(action: coordinator.popToPrevious) {
            if coordinator.navigationStack.count > 1 {
                Image(systemName: "chevron.left")
                Text("Cats")
            }
        }
        .disabled(coordinator.navigationStack.count <= 1)
    }

    private var aboutButton: some View {
        Button(action: { coordinator.navigate(to: .about) }) {
            if coordinator.navigationStack.count == 1 {
                Image(systemName: "info.circle")
            }
        }
    }
}
