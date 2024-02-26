//
//  ListPageViewModel.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

@MainActor
class ListPageViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    let repository: CatRepositoryProtocol
    
    private var currentPage = 0
    
    init(repository: CatRepositoryProtocol) {
        self.repository = repository
        loadNextPage()
    }
    
    func loadNextPage() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            do {
                let newCats = try await repository.getList(page: currentPage)
                self.cats.append(contentsOf: newCats)
                self.isLoading = false
                self.currentPage += 1
            } catch {
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    func shouldLoadMoreData(currentItem: Cat)-> Bool {
        guard let last: Cat = cats.last else { return false }
        return currentItem.id == last.id
    }
}
