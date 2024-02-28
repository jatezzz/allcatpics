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
        launchAppWithStubbing()
    }

    // Common app launch function with request stubbing
    func launchAppWithStubbing(responseFile: String = "list.json", returnCode: Int = 200) {
        app.launchTunnel(
            withOptions: [
                SBTUITunneledApplicationLaunchOptionResetFilesystem,
                SBTUITunneledApplicationLaunchOptionDisableUITextFieldAutocomplete,
                "Testing"
            ]
        ) {
            let response = returnCode == 200 ?
            SBTStubResponse(fileNamed: responseFile) :
            SBTStubResponse(response: [:], returnCode: returnCode)
            self.app.stubRequests(matching: SBTRequestMatch(url: "cataas.com/api/cats.*"), response: response)
        }
    }

    // Test for successful cat selection
    func testCatSelection() {
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        let catID = "fewECg3UpBnPjxNr"
        listPage.selectCat(withID: catID)
    }

    // Test for cat selection with server error
    func testCatSelectionError() {
        launchAppWithStubbing(returnCode: 404) // Re-launch with error stub
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        XCTAssertTrue(listPage.verifyErrorAlert())
    }
}
