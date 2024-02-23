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
    let repository: CatRepository
    
    private var currentPage = 0
    
    init(repository: CatRepository) {
        self.repository = repository
        loadNextPage()
    }
    
    func loadNextPage() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            do {
                let newCats = try await repository.getList(page: currentPage)
                DispatchQueue.main.async {
                    self.cats.append(contentsOf: newCats)
                    self.currentPage += 1
                    self.isLoading = false
                }
            } catch {
                print("An error occurred: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
