//
//  WeatherPage.swift
//  WeatherAppUITests
//
//  Created by Kirill Selivanov on 29.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

final class WeatherPage: CoreTestCase {
    
    func tapButton(accessibilityIdentifier: String) {
        app.buttons[accessibilityIdentifier].tap()
    }

}
