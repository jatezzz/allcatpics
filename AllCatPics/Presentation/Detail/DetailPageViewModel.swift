//
//  DetailPageViewModel.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

class DetailPageViewModel: ObservableObject {
    @Published var cat: Cat?
    private let repository: CatRepository
    private let catId: String
    
    init(repository: CatRepository, catId: String) {
        self.repository = repository
        self.catId = catId
        fetchItemDetail()
    }
    
    func fetchItemDetail() {
        Task {
            do {
                self.cat = try await repository.getDetail(id: catId)
            } catch {
                print("Error fetching cat details: \(error)")
            }
        }
    }
}
