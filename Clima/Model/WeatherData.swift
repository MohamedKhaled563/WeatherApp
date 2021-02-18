//
//  WeatherDate.swift
//  Clima
//
//  Created by Mohamed Khalid on 18/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
