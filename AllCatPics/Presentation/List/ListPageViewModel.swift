//
//  ListPageViewModel.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

class ListPageViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    let repository: CatRepository
    
    init(repository: CatRepository) {
        self.repository = repository
    }
    
    func fetchItems() {
        Task {
            do {
                self.cats = try await repository.getList()
            } catch {
                print("Error fetching cats: \(error)")
            }
        }
    }
}
