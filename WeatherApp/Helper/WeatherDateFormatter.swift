//
//  WeatherDateFormatter.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

class WeatherDateFormatter {
    
    private init() {}
    static let shared = WeatherDateFormatter()
    
    func currentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM YYY"
        let currentDate = dateFormatter.string(from: Date())
        return currentDate
    }
    
}
