//
//  Weather.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import Foundation

struct Weather: Codable {
    
    let main: Main
    let name: String?
    let weather: [WeatherInfo]?
    let wind: Wind
    let sys: Sys
    
}

// Country info
extension Weather {
    struct Sys: Codable {
        let country: String
    }
}

// Wind info
extension Weather {
    
    struct Wind: Codable {
        
        let speed: Double?
        let deg: Int?
        
    }
}

// Main info
extension Weather {
    
    struct Main: Codable {
        
        enum CodingKeys: String, CodingKey {
            case tempreture = "temp"
            case feelsLike = "feels_like"
            case tempretureMin = "temp_min"
            case tempretureMax = "temp_max"
            case pressure = "pressure"
            case humidity = "humidity"
        }
        
        let tempreture: Double?
        let feelsLike: Double?
        let tempretureMin: Double?
        let tempretureMax: Double?
        let pressure: Int?
        let humidity: Int?
    }
    
}

extension Weather {
    struct WeatherInfo: Codable {
        let icon: String?
        let description: String?
    }
}
