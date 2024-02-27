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
    var didAttemptToFetchCats = false

    func getDetail(id: String) async throws -> AllCatPics.Cat {
        try await Task.sleep(nanoseconds: 100_000_000) // 100ms
        if let error = errorToThrow {
            throw error
        }
        return catToReturn
    }

    func getList(page: Int) async throws -> [Cat] {
        try await Task.sleep(nanoseconds: 100_000_000) // 100ms

        if let error = errorToThrow {
            throw error
        }
        return catsToReturn
    }

}
