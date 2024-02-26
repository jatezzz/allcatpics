//
//  ListPageUITests.swift
//  AllCatPicsUITests
//
//  Created by John Trujillo on 24/2/24.
//

import XCTest
import SBTUITestTunnelClient

class ListPageTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    
    func testCatSelection() {
        app.launchTunnel(withOptions: [SBTUITunneledApplicationLaunchOptionResetFilesystem, SBTUITunneledApplicationLaunchOptionDisableUITextFieldAutocomplete, "Testing"]) {
            self.app.stubRequests(matching: SBTRequestMatch(url: "cataas.com/api/cats.*"), response: SBTStubResponse(fileNamed: "list.json"))
        }
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        let catID = "fewECg3UpBnPjxNr" // Use a known cat ID
        listPage.selectCat(withID: catID)
    }
    
    func testCatSelectionError() {
        app.launchTunnel(withOptions: [SBTUITunneledApplicationLaunchOptionResetFilesystem, SBTUITunneledApplicationLaunchOptionDisableUITextFieldAutocomplete, "Testing"]) {
            self.app.stubRequests(matching: SBTRequestMatch(url: "cataas.com/api/cats.*"), response: SBTStubResponse(response: [:], returnCode: 404))
        }
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        XCTAssertTrue(listPage.verifyErrorAlert())
    }
}
