//
//  NameGeneratorTests.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import XCTest
@testable import AllCatPics

class NameGeneratorTests: XCTestCase {

    func testGenerateName() {
        let input = "MUdTa8xitzMo2BwI"
        let expectedOutput = "Mudati"
        XCTAssertEqual(input.generateName(), expectedOutput)
    }
    
    func testGenerateNameWithFewerCharacters() {
        let input = "MTaI"
        let expectedOutput = "Mati"
        XCTAssertEqual(input.generateName(), expectedOutput)
    }
    
    func testGenerateNameWithNoVowels() {
        let input = "MTRPL"
        let expectedOutput = "Mtr"
        XCTAssertEqual(input.generateName(), expectedOutput)
    }
    
    func testGenerateNameWithNoConsonants() {
        let input = "AEIOU"
        let expectedOutput = "Aei"
        XCTAssertEqual(input.generateName(), expectedOutput)
    }
    
    func testEmptyInput() {
        let input = ""
        let expectedOutput = ""
        XCTAssertEqual(input.generateName(), expectedOutput)
    }
}
