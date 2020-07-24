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
    static let shared = LocationManager() //Singletone
    
    override private init() {
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

//MARK: - Get Country by Geoposition
extension LocationManager {
    func getCountry(completionHandler: @escaping ([CLPlacemark]?, Error?) -> ()) {
        guard let location = locationManager.location else { return }
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) -> () in
            completionHandler(placemarks, error)
        }
    }
    
    
    func getLocationInfo(_ placemark: CLPlacemark?) -> String? {
        guard let containsPlacemark = placemark, let country = containsPlacemark.isoCountryCode else { return nil }
        return country
    }
}
