//
//  CatLocalStorage.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

protocol CatLocalStorageProtocol {
    func saveCats(_ cats: [Cat])
    func getCats() -> [Cat]
    func getCatById(_ id: String) -> Cat?
}

class CatLocalStorage: CatLocalStorageProtocol {
    private var cats: [Cat] = []
    
    func saveCats(_ cats: [Cat]) {
        self.cats = cats
    }
    
    func getCats() -> [Cat] {
        cats
    }
    
    func getCatById(_ id: String) -> Cat? {
        cats.first { $0.id == id }
    }
}
