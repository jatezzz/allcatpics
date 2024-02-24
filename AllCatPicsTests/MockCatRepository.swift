//
//  MockCatRepository.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation
@testable import AllCatPics

class MockCatRepository: CatRepositoryProtocol {
    var catsToReturn: [Cat] = []
    var catToReturn: Cat!
    var errorToThrow: Error?
    
    func getList(page: Int) async throws -> [Cat] {
        if let error = errorToThrow {
            throw error
        }
        return catsToReturn
    }
    func getDetail(id: String) async throws -> AllCatPics.Cat {
        catToReturn
    }
    
}

class MockCatAPI: CatAPIProtocol {
    var catsToReturn: [Cat] = []
    var catToReturn: Cat!
    var errorToThrow: Error?

    func fetchCatList(limit: Int, skip: Int) async throws -> [Cat] {
        if let error = errorToThrow {
            throw error
        }
        return catsToReturn
    }

    func fetchCatDetail(id: String) async throws -> Cat {
        if let error = errorToThrow {
            throw error
        }
        return catToReturn
    }
}

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
