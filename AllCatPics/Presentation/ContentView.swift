//
//  ContentView.swift
//  AllCatPics
//
//  Created by John Trujillo on 27/2/24.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var coordinator = DIContainer.shared.coordinator
    // State to manage dynamic navigation
    @State private var isActive = false

    var body: some View {
        NavigationView {
            VStack {
                rootNavigation
                switch coordinator.navigationStack.last {
                case .detail(let cat):
                    detailNavigation(catId: cat.id)
                case .about:
                    aboutNavigation
                default:
                    EmptyView()
                }
            }
            .navigationBarTitle("Cats", displayMode: .automatic)
            .navigationBarItems(trailing: aboutButton)
        }
    }

    private var aboutButton: some View {
        Button(action: { coordinator.navigate(to: .about) }, label: {
            if coordinator.navigationStack.count == 1 {
                Image(systemName: "info.circle")
            }
        })
    }

    // MARK: - Dynamic Navigation Links

    private var rootNavigation: some View {
        ListPage()
            .onAppear {
                self.isActive = false
                coordinator.popToRoot() // TODO fix for complex hierarchies
            }
    }

    private func detailNavigation(catId: String) -> some View {
        NavigationLink(destination: DetailPage(catId: catId), isActive: $isActive) { Text("nope") }
            .hidden()
            .onAppear { self.isActive = true }
    }

    private var aboutNavigation: some View {
        NavigationLink(destination: AboutView(), isActive: $isActive) { EmptyView() }
            .hidden()
            .onAppear { self.isActive = true }
    }

}
