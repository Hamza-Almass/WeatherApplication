//
//  WeatherAppEndPoint.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import Foundation
import UIKit

enum Parameters {
    case url([URLQueryItem])
    case body(params: [String: Any])
}

enum WeatherEndpoint: Endpoint {
    
    case fetchCurrentWeather(latitude: Double, longitude: Double, units: String, country: String)
    
    var baseURL: String {
        return scheme + kBASEURL
    }
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var path: String {
        switch self {
        case .fetchCurrentWeather(_, _, _, _):
            return "/weather"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .fetchCurrentWeather(let latitude, let longitude, let units, let country):
            return .url([
               URLQueryItem(name: "lat", value: "\(latitude)"),
               URLQueryItem(name: "lon", value: "\(longitude)"),
               URLQueryItem(name: "units", value: units),
               URLQueryItem(name: "q", value: country),
               URLQueryItem(name: "appid", value: kAPIKEY)
            ])
        }
    }
        
    
    var method: String {
        switch self {
        case .fetchCurrentWeather:
            return "GET"
        }
    }
    
}
