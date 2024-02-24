//
//  DetailPageViewModel.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

class DetailPageViewModel: ObservableObject {
    @Published var cat: Cat?
    @Published var isLoading = false
    @Published var error: Error?
    @Published var screenTitle: String = ""
    @Published var imageURL: String = ""

    private let repository: CatRepositoryProtocol
    private let catId: String

    init(repository: CatRepositoryProtocol, catId: String) {
        self.repository = repository
        self.catId = catId
        self.screenTitle = catId.generateName()
        self.imageURL = "https://cataas.com/cat/\(catId)"
    }

    func fetchItemDetail() {
        isLoading = true
        error = nil // Reset error state
        Task {
            do {
                let newCat = try await repository.getDetail(id: catId)
                DispatchQueue.main.async {
                    self.cat = newCat
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
    }
    
    func applyTextToImage(_ text: String) {
        self.imageURL = "https://cataas.com/cat/\(catId)/says/\(text)?fontSize=50&fontColor=white"
    }
}
