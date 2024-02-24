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
        let cats = try await api.fetchCatList(limit: itemsPerPage, skip: page * itemsPerPage)
        localStorage.saveCats(cats)
        return cats
    }
    
    func getDetail(id: String) async throws -> Cat {
        if let cachedCat = localStorage.getCatById(id) {
            return cachedCat
        } else {
            let cat = try await api.fetchCatDetail(id: id)
            localStorage.saveCat(cat)
            return cat
        }
    }
}
