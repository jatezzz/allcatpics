//
//  ListPageUITests.swift
//  AllCatPicsUITests
//
//  Created by John Trujillo on 24/2/24.
//

import XCTest
import SBTUITestTunnelClient

class ListPageTests: XCTestCase {
//    let app = XCUIApplication()
    
//    override func setUp() {
//        super.setUp()
//        // Swift
//        app.launchTunnel()
//        continueAfterFailure = false
//    }
    
    
    override func setUp() {
           // Put setup code here. This method is called before the invocation of each test method in the class.

           // In UI tests it is usually best to stop immediately when a failure occurs.
          
        
//            XCUIApplication().terminate()
            super.setUp()
        app.launchTunnel(withOptions: [SBTUITunneledApplicationLaunchOptionResetFilesystem, SBTUITunneledApplicationLaunchOptionDisableUITextFieldAutocomplete]) {
            self.app.stubRequests(matching: SBTRequestMatch(url: "cataas.com/api/cats.*"), response: SBTStubResponse(fileNamed: "list.json"))
            self.app.stubRequests(matching: SBTRequestMatch(url: "cataas.com/cat/.*?json=true"), response: SBTStubResponse(fileNamed: "detail.json"))
        }
//            self.app.stubRequests(matching: SBTRequestMatch(url: "cataas.com/.*"), response: SBTStubResponse(fileNamed: "OptimizelyResponse.json"))
//            app = SBTUITunneledApplication()
        continueAfterFailure = false
           // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
       }
    
    
    func testCatSelection() {
        
//        app.monitorRequests(matching: SBTRequestMatch(url:  "cataas.com/*"))
//        app.stubRequests(
//                       matching: SBTRequestMatch(url:  "cataas.com/*"),
//                       response: SBTStubResponse(response: ["key": "value"], returnCode: 200))
//        
////        let match = SBTRequestMatch.url("google.com")
////        let stubId = app.stubRequests(matching: match, response: SBTStubResponse(response: ["key": "value"])
//        
//        app.launchTunnel()
        let listPage = ListPageScreen(app: app)
        XCTAssertTrue(listPage.isDisplaying, "List Page is not displayed")
        let catID = "fewECg3UpBnPjxNr" // Use a known cat ID
        listPage.selectCat(withID: catID)
    }
}
