//
//  New_York_TimesUITests.swift
//  New York TimesUITests
//
//  Created by Binnilal on 28/07/2021.
//

import XCTest

class New_York_TimesUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["USE_MOCK_SERVER"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPopularArticles() throws {
        let label = app.staticTexts["Biles will not compete Thursday after missing most of the team final because she said she was not in the right mental place to continue without risking severe injury."]
        waitForElementToExist(element: label, seconds: 20)
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Biles will not compete Thursday after missing most of the team final because she said she was not in the right mental place to continue without risking severe injury."].swipeUp()

    }

    func waitForElementToExist(element: XCUIElement, seconds waitSeconds: Double) {
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: waitSeconds, handler: nil)
    }
}
