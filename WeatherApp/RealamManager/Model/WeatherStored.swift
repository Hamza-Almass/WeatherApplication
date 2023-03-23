//
//  WeatherStored.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/23/23.
//

import UIKit
import RealmSwift

class WeatherStored: Object {
    
    @Persisted dynamic var main: Main?
    @Persisted dynamic var name: String?
    @Persisted dynamic var sys: Sys?
    @Persisted dynamic var wind: Wind?
    @Persisted dynamic var weather: RealmSwift.List<WeatherInfo>
    
}

class Main: Object {
    @Persisted dynamic var temp: Double?
    @Persisted dynamic var feels_like: Double?
    @Persisted dynamic var temp_min: Double?
    @Persisted dynamic var temp_max: Double?
    @Persisted dynamic var pressure: Int?
    @Persisted dynamic var humidity: Int?
}

class Sys: Object {
    @Persisted dynamic var country: String?
}

class Wind: Object {
    @Persisted dynamic var speed: Double?
    @Persisted dynamic var deg: Int?
}

class WeatherInfo: Object {
    @Persisted dynamic var icon: String?
}
