//
//  CatLocalStorageTests.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import XCTest
@testable import AllCatPics

class CatLocalStorageTests: XCTestCase {
    
    func testSaveCats_WhenCatsProvided_SavesAllCats() {
        let localStorage = CatLocalStorage()
        let catsToSave: [Cat] = [
            .make(id: "1"),
            .make(id: "2"),
            .make(id: "3"),
        ]
        
        // Act
        localStorage.saveCats(catsToSave)
        
        // Assert
        XCTAssertEqual(localStorage.allCats.count, 3)
    }
    
    func testSaveCat_WhenCatProvided_SavesTheCat() {
        // Arrange
        let localStorage = CatLocalStorage()
        let catToSave : Cat =  .make(id: "1")
        
        // Act
        localStorage.saveCat(catToSave)
        
        // Assert
        XCTAssertEqual(localStorage.allCats.count, 1)
    }
    
    func testGetCatById_WhenExistingCatIDProvided_ReturnsTheCat() {
        // Arrange
        let localStorage = CatLocalStorage()
        let catToSave: Cat = .make(id: "1")
        localStorage.saveCat(catToSave)
        
        // Act
        let retrievedCat = localStorage.getCatById("1")
        
        // Assert
        XCTAssertEqual(retrievedCat?.id, "1")
    }
    
    func testGetCatById_WhenNonExistingCatIDProvided_ReturnsNil() {
        // Arrange
        let localStorage = CatLocalStorage()
        
        // Act
        let retrievedCat = localStorage.getCatById("100")
        
        // Assert
        XCTAssertNil(retrievedCat)
    }
}
