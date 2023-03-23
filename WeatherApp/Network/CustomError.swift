//
//  CustomError.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

enum WeatherError: String, Error {
    case failedDecode = "Something wen't wrong with fetching data"
    case timeOut = "Request time out"
}
