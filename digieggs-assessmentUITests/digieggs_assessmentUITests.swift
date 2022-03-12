//
//  digieggs_assessmentUITests.swift
//  digieggs-assessmentUITests
//
//  Created by Levent ÖZGÜR on 12.03.22.
//

import XCTest

class digieggs_assessmentUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Show filter alert test
    func testShowFilterSuccess() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["filterButton"].tap()
    }

    //Rick filter test
    func testFilterRickSuccess() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["filterButton"].tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "filterNotSelected").element(boundBy: 0).tap()
    }
    
    //Morty filter test
    func testFilterMortySuccess() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["filterButton"].tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "filterNotSelected").element(boundBy: 1).tap()
    }
    
    //infinite scroll test
    func testInfiniteScrooll() throws {
        let app = XCUIApplication()
        app.launch()
        
        for i in  stride(from: 2, to: 24, by: 2) {
            app.tables.cells.containing(.staticText, identifier:"#id: \(i)").element.swipeUp()
        }
    }
}
