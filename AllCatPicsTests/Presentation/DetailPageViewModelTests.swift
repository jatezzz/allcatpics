//
//  DetailPageViewModelTests.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 26/2/24.
//

import XCTest
@testable import AllCatPics

@MainActor
class DetailPageViewModelTests: XCTestCase {
    var viewModel: DetailPageViewModel!
    var mockRepository: MockCatRepository!
    var mockImageSaver: MockImageSaver!

    override func setUp() {
        super.setUp()
        mockRepository = MockCatRepository()
        mockImageSaver = MockImageSaver()
        viewModel = DetailPageViewModel(repository: mockRepository, kingfisherManager: MockKingfisherManager())
        viewModel.imageSaver = mockImageSaver
        mockImageSaver.onFailure = {  [weak self] error in
            self?.viewModel.error = error
        }
        mockImageSaver.onSuccess = { [weak self] in
            guard let self else { return }
            viewModel.alertItem = AlertItem(title: viewModel.successTitle, message: viewModel.successMessage)
        }

    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockImageSaver = nil
        super.tearDown()
    }

    func testViewModel_fetchesItemDetailSuccessfully() {
        let expectation = XCTestExpectation(description: "Successfully loaded cat by id")

        let cat = Cat(tags: ["cute"],
                      createdAt: "2022-01-01",
                      updatedAt: "2022-01-02",
                      mimetype: "image/jpeg",
                      size: nil,
                      id: "123",
                      editedAt: nil)
        mockRepository.catToReturn = cat

        viewModel.fetchItemDetail(for: "123")

        let observation = viewModel.$isLoading.sink { isLoading in
            if !isLoading {
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)

        XCTAssertNotNil(viewModel.cat)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        observation.cancel()
    }

    func testViewModel_handlesErrorWhenLoadingFails() {
        let expectation = XCTestExpectation(description: "Handled error when loading failed")
        mockRepository.errorToThrow = NSError(domain: "example.com", code: 404)

        viewModel.fetchItemDetail(for: "123")
        let observation = viewModel.$error.dropFirst().sink { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)

        XCTAssertNil(viewModel.cat)

        observation.cancel()
    }

    func testViewModel_appliesTextToImageSuccessfully() {
        let validText = "Hello World"
        viewModel.catId = "123" // Assuming this ID is set beforehand

        viewModel.applyTextToImage(validText)

        XCTAssertTrue(viewModel.imageURL.contains(validText), "Image URL should contain the applied text")
        XCTAssertNil(viewModel.alertItem, "Alert item should be nil when text is applied successfully")
    }

    func testViewModel_handlesErrorWhenSavingImageFails() {
        let expectation = XCTestExpectation(description: "Handled error when saving image failed")
        mockImageSaver.success = false
        viewModel.imageURL = "google.com"
        viewModel.saveImageToGallery()

        let observation = viewModel.$error.sink { error in
            if let error {
                XCTAssertNotNil(error, "Error should be set when saving image fails")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)

        observation.cancel()
    }
}
