//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Maxim Andryushin on 23.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager: NSObject {
    
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
}


// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }
}

//MARK: - GetLocation
extension LocationManager {
    func getLocation() -> (Double?, Double?) {
        let location = locationManager.location
        return (location?.coordinate.latitude, location?.coordinate.longitude)
    }
}
