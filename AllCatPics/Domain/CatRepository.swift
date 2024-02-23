//
//  CatRepository.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

class CatRepository {
    private let api: CatAPIProtocol
    private let localStorage: CatLocalStorageProtocol
    private let itemsPerPage = 10
    
    init(api: CatAPIProtocol, localStorage: CatLocalStorageProtocol) {
        self.api = api
        self.localStorage = localStorage
    }
    
    func getList(page: Int = 0) async throws -> [Cat] {
        if let cachedCats = localStorage.getCats(forPage: page), !cachedCats.isEmpty {
            print("cachedCats", page)
            return cachedCats
        } else {
            let cats = try await api.fetchCatList(limit: itemsPerPage, skip: page * itemsPerPage)
            localStorage.saveCats(cats, forPage: page)
            print("fetchCatList", page)
            return cats
        }
    }
    
    func getDetail(id: String) async throws -> Cat {
        if let cachedCat = localStorage.getCatById(id) {
            print("cachedCat", id)
            return cachedCat
        } else {
            let cat = try await api.fetchCatDetail(id: id)
            localStorage.saveCat(cat)
            print("fetchCatDetail", id)
            return cat
        }
    }
}
