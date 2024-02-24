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
    }
    
    func fetchItemDetail() {
        Task {
            do {
                let newCat = try await repository.getDetail(id: catId)
                DispatchQueue.main.async {
                    self.cat = newCat
                }
            } catch {
                print("Error fetching cat details: \(error)")
            }
        }
    }
}
