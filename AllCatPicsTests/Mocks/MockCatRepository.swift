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

