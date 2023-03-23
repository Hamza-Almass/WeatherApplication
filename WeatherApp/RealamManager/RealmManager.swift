//
//  RealmManager.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/23/23.
//

import UIKit
import RealmSwift

var realm = try! Realm()

class RealmManager {
    
    private init() {}
    
    static let shared = RealmManager()
    
    func saveCurrentWeather(weather: Weather) {
        
        if let fetchWeatherStored = realm.objects(WeatherStored.self).first {
            try! realm.write {
                 realm.delete(fetchWeatherStored)
            }
        }
        
        let weatherStored = WeatherStored()
        try! realm.write {
            let main = Main()
            main.feels_like = weather.main.feelsLike
            main.temp = weather.main.tempreture
            main.humidity = weather.main.humidity
            weatherStored.main = main
            weatherStored.name = weather.name
            weatherStored.sys?.country = weather.sys.country
            let wind = Wind()
            wind.speed = weather.wind.speed
            wind.deg = weather.wind.deg
            weatherStored.wind = wind
            let weatherInfo = WeatherInfo()
            let sys = Sys()
            sys.country = weather.sys.country
            weatherStored.sys = sys
            weatherInfo.icon = weather.weather?.first?.icon
            weatherStored.weather.append(weatherInfo)
            realm.add(weatherStored)
        }
    }
    
    func fetchCurrentWeatherStored() -> Weather? {
        guard let weatherStored = realm.objects(WeatherStored.self).first else {
            return nil
        }
        let weather = Weather(main: .init(tempreture: weatherStored.main?.temp,
                                          feelsLike: weatherStored.main?.feels_like,
                                          tempretureMin: nil,
                                          tempretureMax: nil,
                                          pressure: nil,
                                          humidity: weatherStored.main?.humidity),
                                          name: weatherStored.name,
                              weather: [.init(icon: weatherStored.weather.first?.icon, description: nil)],
                              wind: .init(speed: weatherStored.wind?.speed, deg: weatherStored.wind?.deg),
                              sys: .init(country: weatherStored.sys?.country ?? ""))
        return weather
    }
    
}
