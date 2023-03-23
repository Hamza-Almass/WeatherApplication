//
//  Repository.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import Foundation

protocol RepositoryType: AnyObject {
    func getWeatherByUserLocation(latitude: Double,
                                  longitude: Double,
                                  weatherUnits: WeatherUnits,
                                  country: String,
                                  _ completion: @escaping (Result<Weather, Error>) -> Void)
}
