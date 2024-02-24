//
//  ListPageViewModel.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

class ListPageViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    @Published var isLoading: Bool = false
    let repository: CatRepositoryProtocol
    
    var currentPage : Int
    
    init(repository: CatRepositoryProtocol, executeInitialFetch: Bool = false) {
        self.repository = repository
        self.currentPage = 0
        if executeInitialFetch {
            loadNextPage()
        }
    }
    
    func fetchInfo() async -> ([Cat]?, Error?) {
        do {
            let newCats = try await repository.getList(page: currentPage)
            self.currentPage += 1
            return (newCats, nil)
        } catch {
            print("An error occurred: \(error)")
            return (nil, error)
        }
    }
    
    func loadNextPage() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            let (newCats, error) = await fetchInfo()
            DispatchQueue.main.async {
                if error == nil, let newCats {
                    self.cats.append(contentsOf: newCats)
                }
                self.isLoading = false
            }
        }
    }
    
    func shouldLoadMoreData(currentItem: Cat)-> Bool {
        guard let last: Cat = cats.last else { return false }
        return currentItem.id == last.id
    }
}
