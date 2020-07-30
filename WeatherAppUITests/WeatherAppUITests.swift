//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Kirill Selivanov on 29.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import XCTest

class WeatherAppUITests: XCTestCase {
    
    private let weatherPage = WeatherPage()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherView() throws {
        let app = XCUIApplication()
        app.launch()
        
        weatherPage.tapButton(accessibilityIdentifier: "home")
        weatherPage.tapButton(accessibilityIdentifier: "menu")
    
    }
    
    func testCitiesView() throws {
        let app = XCUIApplication()
        app.launch()
        
        weatherPage.tapButton(accessibilityIdentifier: "menu")

        let tableQuery = app.tables
        let exists = NSPredicate(format: "count > 0")
        

        expectation(for: exists, evaluatedWith: tableQuery.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        let cells = tableQuery.cells
        var used = Set<Int>()
        
        var iter = 0
        
        //Check all cells in random order
        while iter < cells.count {
            
            var id: Int
            repeat {
                id = Int.random(in: (0..<cells.count))
            } while used.contains(id)
            used.insert(id)
            
            cells.element(boundBy: id).tap()
            
            weatherPage.tapButton(accessibilityIdentifier: "menu")
            
            Bool.random() ? cells.element(boundBy: Int.random(in: (0..<cells.count))).swipeUp() : cells.element(boundBy: Int.random(in: (0..<cells.count))).swipeDown()
            iter += 1
        }
    }
}
