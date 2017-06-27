/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class ClipBoardTests: BaseTestCase {
    let url = "www.google.com"
    var navigator: Navigator!
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        navigator = createScreenGraph(app).navigator(self)
    }
    
    override func tearDown() {
        navigator = nil
        app = nil
        super.tearDown()
    }
    
    func openTestUrl() {
        
        navigator.openURL(urlString: url)
    }
    
    func checkUrl() {
        let urlTextField = app.textFields["url"]
        waitForValueContains(urlTextField, value: url)
    }
    
    func copyUrl() {
        app.textFields["url"].tap()
        app.textFields["address"].press(forDuration: 1.7)
        app.menuItems["Select All"].tap()
        app.menuItems["Copy"].tap()
    }
    
    func checkCopiedUrl() {
        if let myString = UIPasteboard.general.string {
            var value = app.textFields["url"].value as! String
            value = "\(value)/"
            XCTAssertNotNil(myString)
            XCTAssertEqual(myString, value, "Url matches with the UIPasteboard")
        }
    }
    
    func testClipboard() {
        //Open test url
        openTestUrl()
        
        //Check for test url in the browser
        checkUrl()
        
        //Copy url from the browser
        copyUrl()
        
        //Check copied url is same as in browser
        checkCopiedUrl()

        //Restart the app
        restart(app)
        
        //Skip the intro
        app.buttons["IntroViewController.startBrowsingButton"].tap()
        
        //Wait until recently copied pop up appears
        waitforExistence(app.buttons["Go"])
        
        //Click on the pop up Go button to load the recently copied url
        app.buttons["Go"].tap()
        
    }
    
}
