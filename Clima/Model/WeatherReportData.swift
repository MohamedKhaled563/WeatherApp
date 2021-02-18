//
//  WeatherReportData.swift
//  Clima
//
//  Created by Mohamed Khalid on 18/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherReportData: Decodable{
    let daily: [Day]
}


struct Day: Decodable {
    let humidity: Int
    let temp: Temp
}

struct Temp: Decodable {
    let day: Double
}
