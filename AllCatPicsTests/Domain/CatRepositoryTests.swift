//
//  CatRepositoryTests.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import XCTest
@testable import AllCatPics

final class CatRepositoryTests: XCTestCase {

    func testLoadNextPage_WhenSuccess_AppendsNewCats() async throws {
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

    func testLoadNextPage_WhenFailure_CapturesError() async throws {
        // Arrange
        let mockCatAPI = MockCatAPI()
        let mockCatLocalStorage = MockCatLocalStorage()
        mockCatAPI.errorToThrow = NSError(domain: "TestError", code: 1, userInfo: nil)

        let repository = CatRepository(api: mockCatAPI, localStorage: mockCatLocalStorage)

        // Act
        var expectedError: Error?
        do {
            _ = try await repository.getList(page: 0)
        } catch {
            expectedError = error
        }

        // Assert
        XCTAssertNotNil(expectedError)
        XCTAssertEqual((expectedError as NSError?)?.domain, "TestError")
        XCTAssertEqual((expectedError as NSError?)?.code, 1)
    }

}
