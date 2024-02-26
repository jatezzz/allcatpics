//
//  DetailPageViewModel.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation
import Kingfisher
import UIKit

@MainActor
class DetailPageViewModel: ObservableObject {
    @Published var cat: Cat?
    @Published var isLoading = false
    @Published var error: Error? {
        didSet{
            self.alertItem = (error != nil) ? AlertItem() : nil
        }
    }
    @Published var screenTitle: String = ""
    @Published var imageURL: String = ""
    @Published var isSaving = false
    @Published var alertItem: AlertItem?
    
    private let repository: CatRepositoryProtocol
    private var catId: String?
    private var imageSaver : ImageSaver?
    
    init(repository: CatRepositoryProtocol) {
        self.repository = repository
        
        self.imageSaver = ImageSaver { error in
            self.error = error
            self.isSaving = false
            self.isLoading = false
        }
    }
    
    func fetchItemDetail(for catId: String) {
        self.catId = catId
        self.imageURL = CatAPIEndpoints.catImageURL(id: catId)
        self.screenTitle = catId.generateName()
        isLoading = true
        error = nil // Reset error state
        Task {
            do {
                let newCat = try await repository.getDetail(id: catId)
                self.cat = newCat
                self.isLoading = false
            } catch {
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    func applyTextToImage(_ text: String) {
        guard !text.isEmpty, let catId else {
            alertItem = AlertItem(title: "Wrong text", message: "Plese insert a valid text")
            return
        }
        alertItem = nil
        self.imageURL = CatAPIEndpoints.catSaysImageURL(id: catId, text: text)
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
