//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/23/23.
//

import UIKit
import CoreLocation

protocol LocationManagerType {
    func getUserLocation(completion: @escaping ((CLLocation?, Error?) -> Void))
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerType {
    
    private let manager = CLLocationManager()
    var completion: ((CLLocation?, Error?) -> Void)?
    
    func getUserLocation(completion: @escaping ((CLLocation?, Error?) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location, nil)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil, error)
    }
    
}
