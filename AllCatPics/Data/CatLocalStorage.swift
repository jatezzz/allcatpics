//
//  CatLocalStorage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

protocol CatLocalStorageProtocol {
    func saveCats(_ cats: [Cat])
    func saveCat(_ cat: Cat)
    func getCatById(_ id: String) -> Cat?
}

class CatLocalStorage: CatLocalStorageProtocol {
    private var allCats: Set<Cat> = []

    func saveCats(_ cats: [Cat]) {
        cats.forEach({allCats.insert($0)})
    }
    
    func saveCat(_ cat: Cat) {
        allCats.insert(cat)
    }

    func getCatById(_ id: String) -> Cat? {
        return allCats.first(where: { $0.id == id })
    }
}
