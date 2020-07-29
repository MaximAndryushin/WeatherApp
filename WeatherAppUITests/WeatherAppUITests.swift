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
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        weatherPage.tapButton(accessibilityIdentifier: "home")
        weatherPage.tapButton(accessibilityIdentifier: "menu")
    }
}
