//
//  DIContainer.swift
//  AllCatPics
//
//  Created by John Trujillo on 26/2/24.
//

import Foundation

protocol DIContainerProtocol {
    func resolveCatRepository() -> CatRepositoryProtocol
    func resolveListPageViewModel() -> ListPageViewModel
    func resolveDetailPageViewModel() -> DetailPageViewModel
}

class DIContainer: DIContainerProtocol {
    static let shared = DIContainer(coordinator: NavigationCoordinator())

    let coordinator: NavigationCoordinator

    init(coordinator: NavigationCoordinator) {
        self.coordinator = coordinator
    }
    func resolveCatRepository() -> CatRepositoryProtocol {
        return CatRepository(api: CatAPI(), localStorage: CatLocalStorage())
    }

    @MainActor func resolveListPageViewModel() -> ListPageViewModel {
        return ListPageViewModel(repository: resolveCatRepository())
    }

    @MainActor func resolveDetailPageViewModel() -> DetailPageViewModel {
        return DetailPageViewModel(repository: resolveCatRepository())
    }
}
