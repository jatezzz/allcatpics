//
//  CatRepositoryTest.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import XCTest
@testable import AllCatPics

final class CatRepositoryTest: XCTestCase {

    func testLoadNextPageSuccess() async throws {
        let mockCatAPI = MockCatAPI()
        let mockCatLocalStorage = MockCatLocalStorage()
        mockCatAPI.catsToReturn = [.make()]
        
        let repository = CatRepository(api: mockCatAPI, localStorage: mockCatLocalStorage)
        
        // Perform the action
        let newCats = try? await repository.getList(page: 0)
        
        // Assert the final state
        XCTAssertNotNil(newCats)
        XCTAssertEqual(newCats!.count, 1)
        XCTAssertEqual(newCats!.first?.id, "123")
    }
    
    func testLoadNextPageFailure() async throws {
        let mockCatAPI = MockCatAPI()
        let mockCatLocalStorage = MockCatLocalStorage()
        mockCatAPI.errorToThrow = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        let repository = CatRepository(api: mockCatAPI, localStorage: mockCatLocalStorage)
        
        // Perform the action
        let newCats = try? await repository.getList(page: 0)
        
        // Assert the final state
        XCTAssertNil(newCats)
    }
}
