//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import Foundation
import UIKit

protocol WeatherViewModelDelegate: AnyObject {
    func finishWithError()
    func FinishWithSuccess()
}

protocol WeatherViewModelType {
    var inputs: WeatherViewModelInput { get }
    var outputs: WeatherViewModelOutput { get }
}

protocol WeatherViewModelInput {
    func load()
    func refresh()
    func selectedSegmentIndex(index: Int)
    func getWeatherByCountry(_ country: String)
}

protocol WeatherViewModelOutput {
    var navigationTitle: String { get }
    var humidity: String { get }
    var windSpeed: String { get }
    var country: String { get }
    var iconLocation: UIImage? { get }
    var iconWeather: UIImage? { get }
    var tempreture: String { get }
    var currentDate: String { get }
    var errorTitle: String { get }
    var errorMessage: String { get }
    var weatherUnits: [String] { get }
    var selectedSegmentIndex: Int { get }
    var iconRefreshButton: UIImage? { get }
}

class WeatherViewModel: WeatherViewModelType {
    
    var inputs: WeatherViewModelInput { self }
    var outputs: WeatherViewModelOutput { self }
    
    weak var delegate: WeatherViewModelDelegate?
    
    private let weatherRepository: RepositoryType
    private let locationManager: LocationManagerType
    private var units: WeatherUnits
    private var countrySearch: String
    
    private var weather: Weather?
    private var error: Error?
    
    init(weatherRepository: RepositoryType,
         locationManager: LocationManagerType,
         units: WeatherUnits,
         countrySearch: String) {
        self.units = units
        self.countrySearch = countrySearch
        self.weatherRepository = weatherRepository
        self.locationManager = locationManager
        fetchOfflineWeather()
    }
    
    private func fetchOfflineWeather() {
        if let weather = RealmManager.shared.fetchCurrentWeatherStored() {
            self.weather = weather
        }
    }
    
    private func getCurrentWeather(userLatitude: Double,
                                   userLonitude: Double, weatherUnits: WeatherUnits, country: String) {
        weatherRepository.getWeatherByUserLocation(latitude: userLatitude,
                                                   longitude: userLonitude, weatherUnits: weatherUnits, country: country) { (result: Result<Weather, Error>) in
            
            switch result {
            case .success(let success):
                self.weather = success
                RealmManager.shared.saveCurrentWeather(weather: success)
                self.delegate?.FinishWithSuccess()
            case .failure(let error):
                self.error = error
                self.delegate?.finishWithError()
            }
             
        }
    }
    
}

extension WeatherViewModel: WeatherViewModelInput {
    
    func getWeatherByCountry(_ country: String) {
        self.countrySearch = country
        load()
    }

    func selectedSegmentIndex(index: Int) {
        switch index {
        case 0:
            self.units = .fahrenheit
        case 1:
            self.units = .celsius
        default:
            self.units = .kelvin
        }
        load()
    }
    
    func refresh() {
        load()
    }
    
    func load() {
        locationManager.getUserLocation { location , error in
            if let error = error {
                self.error = error
                self.delegate?.finishWithError()
                return
            }
            self.getCurrentWeather(userLatitude: location?.coordinate.latitude ?? 0,
                                   userLonitude: location?.coordinate.longitude ?? 0,
                                   weatherUnits: self.units, country: self.countrySearch)
            
        }
    }
    
}

extension WeatherViewModel: WeatherViewModelOutput {
    
    var iconRefreshButton: UIImage? {
        UIImage(systemName: "arrow.clockwise")
    }
    
    var navigationTitle: String {
        return "Weather"
    }
    
    var humidity: String {
       "Humidity \(self.weather?.main.humidity ?? 0)"
    }
    
    var windSpeed: String {
        let speedOnHour = self.units == .fahrenheit ? "miles/hour" : "meter/sec"
        return "Speed \(self.weather?.wind.speed ?? 0) \(speedOnHour)"
    }
    
    var country: String {
        "\(self.weather?.sys.country ?? ""), \(self.weather?.name ?? "")"
    }
    
    var iconLocation: UIImage? {
        return UIImage(systemName: "map.circle.fill")
    }
    
    var iconWeather: UIImage? {
        return UIImage(named: self.weather?.weather?.first?.icon ?? "")
    }
    
    var tempreture: String {
        let tempretureSymbol = self.units == .kelvin ? "K°" : self.units == .fahrenheit ? "F°" : "C°"
        return "\(self.weather?.main.tempreture ?? 0) \(tempretureSymbol)"
    }
    
    var currentDate: String {
        WeatherDateFormatter.shared.currentDate()
    }
    
    var errorTitle: String {
        "Error"
    }
    
    var errorMessage: String {
        self.error?.localizedDescription ?? ""
    }
    
    var weatherUnits: [String] {
        WeatherUnits.allCases.map { $0 == .fahrenheit ? "Fahrenheit" : $0 == .celsius ? "Celsius" : "Kelvin" }
    }
    
    var selectedSegmentIndex: Int {
        return units == .kelvin ? 2 : units == .fahrenheit ? 0 : 1
    }
    
}
