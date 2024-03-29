//
//  ListPageScreen.swift
//  AllCatPicsUITests
//
//  Created by John Trujillo on 24/2/24.
//

import XCTest

class ListPageScreen {
    private var app: XCUIApplication

    private var catCardIdentifier = "catCard_"

    init(app: XCUIApplication) {
        self.app = app
    }

    var isDisplaying: Bool {
        return app.navigationBars["AllCatPics"].exists
    }

    func selectCat(withID catID: String) {
        app.buttons["catCard_\(catID)"].firstMatch.tap()
    }

    func verifyErrorAlert() -> Bool {
        app.buttons["OK"].exists
    }
}
