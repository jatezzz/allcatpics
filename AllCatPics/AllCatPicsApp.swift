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
            ListPage()
            
        }
    }
}
struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}
