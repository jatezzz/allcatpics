//
//  AllCatPicsApp.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

@main
struct AllCatPicsApp: App {
    var body: some Scene {
        WindowGroup {
            ListPage(viewModel: ListPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage())))
        }
    }
}
