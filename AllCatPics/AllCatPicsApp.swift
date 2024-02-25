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
    
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        
        print("will takeOff")
        #if DEBUG
        print("takeOff")
            SBTUITestTunnelServer.takeOff()
        #endif
    }
    var body: some Scene {
        WindowGroup {
            ListPage(viewModel: ListPageViewModel(repository: CatRepository(api: CatAPI(), localStorage: CatLocalStorage())))
        }
    }
}
