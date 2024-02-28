//
//  File.swift
//  AllCatPicsUITests
//
//  Created by John Trujillo on 28/2/24.
//

import Foundation
import XCTest

class DetailPageScreen {
    private var app: XCUIApplication

    private let loadingIndicator = "loadingIndicator"

    init(app: XCUIApplication) {
        self.app = app
    }

    var id: String {
        return app.staticTexts["detail.id"].label
    }

    var isDisplaying: Bool {
        return app.staticTexts["detail.page.description"].waitForExistence(timeout: 10)
    }

    var isLoading: Bool {
        return app.activityIndicators[loadingIndicator].exists
    }

    var isDownloadButtonVisible: Bool {
        return app.buttons["detail.downloadButton"].exists
    }

    func tapDownloadButton() {
        app.buttons["detail.downloadButton"].tap()
    }

    func applyTextToImage(_ text: String) {
        let textField = app.textFields["detail.addTextToImage"]
        textField.tap()
        textField.typeText(text)
        _ = app.buttons["detail.applyButton"].waitForExistence(timeout: 10)
        app.buttons["detail.applyButton"].tap()
    }

}
