//
//  StringExtensionTests.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 26/2/24.
//

import XCTest
@testable import AllCatPics

class StringExtensionTests: XCTestCase {

    func testFormatDateString_WithDefaultFormats_ShouldReturnFormattedDate() {
        // Given
        let dateString = "2022-02-23T12:34:56.789Z"
        let expectedFormattedDate = "Feb 23, 2022"

        // When
        let formattedDate = dateString.formatDateString()

        // Then
        XCTAssertEqual(formattedDate, expectedFormattedDate)
    }

    func testFormatDateString_WithCustomFormats_ShouldReturnFormattedDate() {
        // Given
        let dateString = "2022-02-23T12:34:56.789Z"
        let fromFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let toFormat = "EEEE, MMMM dd, yyyy"
        let expectedFormattedDate = "Wednesday, February 23, 2022"

        // When
        let formattedDate = dateString.formatDateString(fromFormat: fromFormat, toFormat: toFormat)

        // Then
        XCTAssertEqual(formattedDate, expectedFormattedDate)
    }

    func testFormatDateString_WithInvalidDateString_ShouldReturnEmptyString() {
        // Given
        let invalidDateString = "Invalid Date"

        // When
        let formattedDate = invalidDateString.formatDateString()

        // Then
        XCTAssertEqual(formattedDate, "")
    }
}
