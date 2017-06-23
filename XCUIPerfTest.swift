/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class XCUIPerfTest: BaseTestCase {
        
    var navigator: Navigator!
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        navigator = createScreenGraph(app).navigator(self)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testperformance() {
        navigator.goto(TabTray)
        self.measure {
            self.navigator.goto(NewTabScreen)
            self.navigator.goto(TabTray)
        }
    }
    
}
