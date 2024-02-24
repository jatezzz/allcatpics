//
//  ListPageUITests.swift
//  AllCatPicsUITests
//
//  Created by John Trujillo on 24/2/24.
//

import XCTest

class ListPageTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
    }
    
    func testCatSelection() {
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        let catID = "mwKeb0eb6TRsYUqq" // Use a known cat ID
        listPage.selectCat(withID: catID)
    }
}
