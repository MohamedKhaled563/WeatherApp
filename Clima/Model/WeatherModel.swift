//
//  WeatherModel.swift
//  Clima
//
//  Created by Mohamed Khalid on 18/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let weatherID: Int
    let temperature: Double
    let description: String
    let humidity: Int
    var temperatureString: String{
        return String(format: "%.2f", temperature)
    }
    var conditionImage: String{
        switch weatherID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
