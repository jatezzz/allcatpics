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
    
    func saveImageToGallery() {
        guard let url = URL(string: imageURL), !isSaving else { return }
        isSaving = true
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let value):
                ImageSaver.shared.saveImage(value.image)
                self.isSaving = false
            case .failure(let error):
                print(error) // Handle the error appropriately
                self.isSaving = false
            }
        }
    }
}

class ImageSaver: NSObject {
    static let shared = ImageSaver()

    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedImage(_:error:context:)), nil)
    }

    @objc func savedImage(_ im: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
        if let err = error {
            print("Error saving image: \(err)")
            return
        }
        print("Image saved successfully.")
    }
}
