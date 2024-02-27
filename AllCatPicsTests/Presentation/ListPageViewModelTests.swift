//
//  ListPageViewModelTests.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 26/2/24.
//

import XCTest
@testable import AllCatPics

@MainActor
class ListPageViewModelTests: XCTestCase {

    var viewModel: ListPageViewModel!
    var mockRepository: MockCatRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockCatRepository()
        viewModel = ListPageViewModel(repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    func testViewModel_loadsNextPageSuccessfully() {
           let expectation = XCTestExpectation(description: "Successfully loaded next page of cats")
           mockRepository.catsToReturn = [Cat(tags: ["tag1"], createdAt: nil, updatedAt: nil, mimetype: nil, size: nil, id: "123", editedAt: nil)]

           let observation = viewModel.$cats.dropFirst().sink { cats in
               XCTAssertEqual(cats.count, 1)
               expectation.fulfill()
           }

           wait(for: [expectation], timeout: 5.0)

           XCTAssertNil(viewModel.error)

           observation.cancel()
       }
    func testViewModel_handlesErrorWhenLoadingFails() {
           let expectation = XCTestExpectation(description: "Handled error when loading failed")
           mockRepository.errorToThrow = NSError(domain: "example.com", code: 404)

           let observation = viewModel.$error.dropFirst().sink { error in
               XCTAssertNotNil(error)
               expectation.fulfill()
           }

           wait(for: [expectation], timeout: 5.0)

           XCTAssertTrue(viewModel.cats.isEmpty)

           observation.cancel()
       }

       func testViewModel_doesNotLoadNextPageWhileAlreadyLoading() {
           viewModel.isLoading = true

           viewModel.loadNextPage()

           XCTAssertTrue(mockRepository.didAttemptToFetchCats == false, "Should not attempt to load next page while already loading")
       }

      func testViewModel_shouldLoadMoreDataReturnsCorrectValue() {
          viewModel.cats = [Cat(tags: [], createdAt: nil, updatedAt: nil, mimetype: nil, size: nil, id: "1", editedAt: nil)]

          let lastCat = viewModel.cats.last!
          XCTAssertTrue(viewModel.shouldLoadMoreData(currentItem: lastCat), "Should load more data when the current item is the last item")

          let notLastCat = Cat(tags: [], createdAt: nil, updatedAt: nil, mimetype: nil, size: nil, id: "2", editedAt: nil)
          XCTAssertFalse(viewModel.shouldLoadMoreData(currentItem: notLastCat), "Should not load more data when the current item is not the last item")
      }
}
