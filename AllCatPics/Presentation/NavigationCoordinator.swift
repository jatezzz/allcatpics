//
//  NavigationCoordinator.swift
//  AllCatPics
//
//  Created by John Trujillo on 27/2/24.
//

import Foundation

enum NavigationPage {
    case root
    case detail(cat: Cat)
    case about
}

class NavigationCoordinator: ObservableObject {
    @Published var navigationStack: [NavigationPage] = [.root]

    func navigate(to page: NavigationPage) {
        navigationStack.append(page)
    }

    func popToPrevious() {
        _ = navigationStack.popLast()
    }

    func popToRoot() {
        navigationStack = [.root]
    }
}
