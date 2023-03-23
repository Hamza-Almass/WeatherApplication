//
//  CoreColor.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/23/23.
//

import UIKit

enum CoreColor: String {
    
    case myPrimaryColor = "MyPrimaryColor"
    case mySecondaryColor = "MySecondaryColor"
    
    var color: UIColor {
        switch self {
        case .myPrimaryColor:
            return UIColor(named: self.rawValue)!
        case .mySecondaryColor:
            return UIColor(named: self.rawValue)!
        }
    }
}
