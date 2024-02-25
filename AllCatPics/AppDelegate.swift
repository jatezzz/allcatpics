//
//  AppDelegate.swift
//  AllCatPics
//
//  Created by John Trujillo on 24/2/24.
//

import UIKit
#if DEBUG
    import SBTUITestTunnelServer
#endif

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        #if DEBUG
            SBTUITestTunnelServer.takeOff()
        #endif

        return true
    }
}
