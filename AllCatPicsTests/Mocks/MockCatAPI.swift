//
//  MockCatAPI.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation
@testable import AllCatPics

class MockCatAPI: CatAPIProtocol {
    var catsToReturn: [Cat] = []
    var catToReturn: Cat!
    var errorToThrow: Error?

    func fetchCatList(limit: Int, skip: Int) async -> Result<[AllCatPics.Cat], Error> {
        if let error = errorToThrow {
            return .failure(error)
        }
        return .success( catsToReturn)
    }
    
    func fetchCatDetail(id: String) async -> Result<AllCatPics.Cat, Error> {
        if let error = errorToThrow {
            return .failure(error)
        }
        return .success( catToReturn)
    }
    
}
