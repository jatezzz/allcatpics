//
//  AllCatPicsApp.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import SwiftUI

#if DEBUG
import SBTUITestTunnelServer
#endif

@main
struct AllCatPicsApp: App {
    init() {
        #if DEBUG
            SBTUITestTunnelServer.takeOff()
        #endif
    }
    var body: some Scene {
        WindowGroup {
            ListPage(viewModel: ListPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage())))
        }
    }
}