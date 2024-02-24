//
//  ListPageViewModelTests.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import XCTest
@testable import AllCatPics

final class ListPageViewModelTests: XCTestCase {

    func testLoadNextPageSuccess() async throws {
        let mockRepository = MockCatRepository()
        mockRepository.catsToReturn = [.make()]
        
        let viewModel = ListPageViewModel(repository: mockRepository)
        
        // Perform the action
        let (newCats, error) = await viewModel.fetchInfo()
        
        // Assert the final state
        XCTAssertNotNil(newCats)
        XCTAssertNil(error)
        XCTAssertEqual(newCats!.count, 1)
        XCTAssertEqual(newCats!.first?.id, "123")
    }

    func testLoadNextPageFailure() async throws {
        let mockRepository = MockCatRepository()
        mockRepository.errorToThrow = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        let viewModel = ListPageViewModel(repository: mockRepository)
        
        // Perform the action
        let (newCats, error) = await viewModel.fetchInfo()
        
        // Assert the final state
        XCTAssertNotNil(error)
        XCTAssertNil(newCats)
    }

    func testPagination() async throws {
        let mockRepository = MockCatRepository()
        mockRepository.catsToReturn = [.make()]
        
        let viewModel = ListPageViewModel(repository: mockRepository)
        
        XCTAssertEqual(viewModel.currentPage, 0)
        // Perform the action
        _ = await viewModel.fetchInfo()
        
        XCTAssertEqual(viewModel.currentPage, 1)
        // Change the mock to return different cats for the next page
        mockRepository.catsToReturn = [.make(id: "456")]
        
        // Perform the action
        let (newCats, error) = await viewModel.fetchInfo()
        
        // Assert the final state
        XCTAssertNotNil(newCats)
        XCTAssertNil(error)
        XCTAssertEqual(newCats!.count, 1)
        XCTAssertEqual(viewModel.currentPage, 2)
    }


}
