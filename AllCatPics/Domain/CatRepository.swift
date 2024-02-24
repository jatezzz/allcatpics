//
//  CatRepository.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

protocol CatRepositoryProtocol {
    func getList(page: Int) async throws -> [Cat]
    func getDetail(id: String) async throws -> Cat
}

class CatRepository: CatRepositoryProtocol {
    private let api: CatAPIProtocol
    private let localStorage: CatLocalStorageProtocol
    private let itemsPerPage = 10
    
    init(api: CatAPIProtocol, localStorage: CatLocalStorageProtocol) {
        self.api = api
        self.localStorage = localStorage
    }
    
    func getList(page: Int = 0) async throws -> [Cat] {
        let result = await api.fetchCatList(limit: itemsPerPage, skip: page * itemsPerPage)
        switch result {
        case .success(var cats):
            // Apply name generation to each cat
            let cats = cats.map { cat in
                var modifiableCat = cat
                modifiableCat.displayName = cat.id.generateName()
                return modifiableCat
            }
            localStorage.saveCats(cats)
            return cats
        case .failure(let error):
           throw error
        }
    }
    
    func getDetail(id: String) async throws -> Cat {
        if let cachedCat = localStorage.getCatById(id) {
            return cachedCat
        } else {
            let result = await api.fetchCatDetail(id: id)
            switch result {
            case .success(var cat):
                cat.displayName = cat.id.generateName()
                localStorage.saveCat(cat)
                return cat
            case .failure(let error):
               throw error
            }
        }
    }
}
