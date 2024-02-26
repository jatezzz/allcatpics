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

protocol DIContainerProtocol {
    func resolve() -> CatRepositoryProtocol
    func resolveListPageViewModel() -> ListPageViewModel
    func resolveDetailPageViewModel(catId: String) -> DetailPageViewModel
}

class DIContainer: DIContainerProtocol {
    static let shared = DIContainer()
    func resolve() -> CatRepositoryProtocol {
        return CatRepository(api: CatAPI(), localStorage: CatLocalStorage())
    }
    
    @MainActor func resolveListPageViewModel() -> ListPageViewModel {
        return ListPageViewModel(repository: resolve())
    }
    func resolveDetailPageViewModel(catId: String) -> DetailPageViewModel {
        return DetailPageViewModel(repository: resolve(), catId: catId)
    }
}

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
