//
//  CatLocalStorage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

protocol CatLocalStorageProtocol {
    func saveCats(_ cats: [Cat], forPage page: Int)
    func saveCat(_ cat: Cat)
    func getCats(forPage page: Int) -> [Cat]?
    func getCatById(_ id: String) -> Cat?
}
class CatLocalStorage: CatLocalStorageProtocol {
    private var catsByPage: [Int: [Cat]] = [:]
    private var allCats: [Cat] = []

    func saveCats(_ cats: [Cat], forPage page: Int) {
        catsByPage[page] = cats
    }
    func saveCat(_ cat: Cat) {
        allCats.append(cat)
    }

    func getCats(forPage page: Int) -> [Cat]? {
        return catsByPage[page]
    }
    
    func getCatById(_ id: String) -> Cat? {
        for (_, cats) in catsByPage {
            if let cat = cats.first(where: { $0.id == id }) {
                return cat
            }
        }
        return allCats.first(where: { $0.id == id })
    }
}
