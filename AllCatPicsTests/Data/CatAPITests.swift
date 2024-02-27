//
//  CatAPITests.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation
import XCTest
@testable import AllCatPics

final class CatAPITests: XCTestCase {
    func testFetchCatList_WhenSuccess_verifyParsedData() async throws {
        let mockSession = MockURLSession()
        let testData = """
        [{
            "tags": [
                "xbox",
                "kitten",
                "farted",
                "achievement"
            ],
            "mimetype": "image/png",
            "size": 5519,
            "createdAt": "2024-02-10T22:10:25.596Z",
            "editedAt": "2024-02-14T15:29:26.409Z",
            "_id": "1"
         }]
        """.data(using: .utf8)!
        mockSession.mockData = testData
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "https://mock.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        let api = CatAPI(session: mockSession)
        let result = await api.fetchCatList()

        switch result {
        case .success(let cats):
            XCTAssertEqual(cats.count, 1)
            XCTAssertEqual(cats.first?.id, "1")
        case .failure(let error):
            XCTFail("Expected success but got \(error)")
        }
    }

    func testFetchCatListFailure() async {
        let mockSession = MockURLSession()
        mockSession.mockError = URLError(.badServerResponse)

        let api = CatAPI(session: mockSession)
        let result = await api.fetchCatList()

        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertTrue(error is URLError)
        }
    }
}
