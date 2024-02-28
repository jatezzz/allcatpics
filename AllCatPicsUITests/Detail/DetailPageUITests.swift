//
//  DetailPageTests.swift
//  AllCatPicsUITests
//
//  Created by John Trujillo on 28/2/24.
//

import XCTest
import SBTUITestTunnelClient

class DetailPageTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        launchAppWithDetailStubbing()
    }

    func launchAppWithDetailStubbing(responseFile: String = "list.json", returnCode: Int = 200) {
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

    func testCatDetailInformation() {
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        let catID = "fewECg3UpBnPjxNr"
        listPage.selectCat(withID: catID)
        let detailPage = DetailPageScreen(app: app)
        XCTAssertTrue(detailPage.isDisplaying, "Detail Page is not displayed after selecting a cat")

        // Verify detail information
        XCTAssertTrue(detailPage.id.contains(catID), "Id is not matching")
    }

    func testDownloadImage() {
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        let catID = "fewECg3UpBnPjxNr"
        listPage.selectCat(withID: catID)
        let detailPage = DetailPageScreen(app: app)
        XCTAssertTrue(detailPage.isDisplaying, "Detail Page is not displayed after selecting a cat")

        XCTAssertTrue(detailPage.isDownloadButtonVisible, "Download button is not visible on Detail Page")
        detailPage.tapDownloadButton()
    }

    func testApplyTextToImage() {
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        let catID = "fewECg3UpBnPjxNr"
        listPage.selectCat(withID: catID)
        let detailPage = DetailPageScreen(app: app)
        XCTAssertTrue(detailPage.isDisplaying, "Detail Page is not displayed after selecting a cat")

        detailPage.applyTextToImage("Hi")
    }

}
