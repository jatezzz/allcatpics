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
            guard let error else {
                self.alertItem =  nil
                return
            }
            print(error)
            self.alertItem = AlertItem()
        }
    }
    @Published var screenTitle: String = ""
    @Published var imageURL: String = ""
    @Published var isSaving = false
    @Published var alertItem: AlertItem?
    
    private let repository: CatRepositoryProtocol
    var catId: String?
    var imageSaver : ImageSaverProtocol?
    var kingfisherManager : KingfisherManagerProtocol
    
    let successTitle = "Success"
    let successMessage = "Image saved."
    private let wrongTextTitle = "Wrong text"
    private let wrongTextMessage = "Please insert a valid text"
    
    init(repository: CatRepositoryProtocol, kingfisherManager: KingfisherManagerProtocol = KingfisherManager.shared) {
        self.repository = repository
        self.kingfisherManager = kingfisherManager
        
        self.imageSaver = ImageSaver(onFailure: {  [weak self] error in
            self?.error = error
        }, onSuccess: { [weak self] in
            guard let self else { return }
            self.alertItem = AlertItem(title: self.successTitle, message: self.successMessage)
        })
    }
    
    func fetchItemDetail(for catId: String) {
        self.catId = catId
        self.imageURL = CatAPIEndpoints.catImageURL(id: catId)
        self.screenTitle = catId.generateName()
        isLoading = true
        error = nil
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
            alertItem = AlertItem(title: wrongTextTitle, message: wrongTextMessage)
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
        kingfisherManager.retrieveImage(with: url,
                                        options: nil,
                                            progressBlock: nil,
                                            downloadTaskUpdated: nil) { [weak self] result in
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
    
    func onImageFeailure(){
        alertItem = AlertItem(title: "Image loading error", message: "Is there a problem loading the image.")
    }
}
