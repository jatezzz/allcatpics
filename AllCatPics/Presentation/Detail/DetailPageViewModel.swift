//
//  DetailPageViewModel.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation
import Kingfisher
import UIKit

class DetailPageViewModel: ObservableObject {
    @Published var cat: Cat?
    @Published var isLoading = false
    @Published var error: Error?
    @Published var screenTitle: String = ""
    @Published var imageURL: String = ""
    @Published var isSaving = false

    private let repository: CatRepositoryProtocol
    private let catId: String
    private var imageSaver : ImageSaver?

    init(repository: CatRepositoryProtocol, catId: String) {
        self.repository = repository
        self.catId = catId
        self.screenTitle = catId.generateName()
        self.imageURL = "https://cataas.com/cat/\(catId)"
        self.imageSaver = ImageSaver { error in
            self.error = error
            self.isSaving = false
            self.isLoading = false
        }
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
    
    func saveImageToGallery() {
        guard let url = URL(string: imageURL), !isSaving else { return }
        isLoading = true
        isSaving = true
        error = nil
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                self.imageSaver?.saveImage(value.image)
                self.isSaving = false
                self.isLoading = false
            case .failure(let error):
                self.error = error
                self.isSaving = false
                self.isLoading = false
            }
        }
    }
}
