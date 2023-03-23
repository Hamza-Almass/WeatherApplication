//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import Foundation


class WeatherRepository: RepositoryType {
    
    func getWeatherByUserLocation(latitude: Double,
                                  longitude: Double,
                                  weatherUnits: WeatherUnits = .kelvin,
                                  country: String,
                                  _ completion: @escaping (Result<Weather, Error>) -> Void) {
        Network.request(endpoint: WeatherEndpoint
            .fetchCurrentWeather(latitude: latitude, longitude: longitude, units: weatherUnits.rawValue, country: country), completion: completion)
    }
}
