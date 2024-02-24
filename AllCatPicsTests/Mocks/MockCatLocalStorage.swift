//
//  MockCatLocalStorage.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation
@testable import AllCatPics

class MockCatLocalStorage: CatLocalStorageProtocol {
    var savedCats: [Cat] = []
    var savedCat: Cat?

    func saveCats(_ cats: [Cat]) {
        savedCats = cats
    }

    func saveCat(_ cat: Cat) {
        savedCat = cat
    }

    func getCatById(_ id: String) -> Cat? {
        return savedCats.first(where: { $0.id == id })
    }
}
