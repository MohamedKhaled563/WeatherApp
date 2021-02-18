//
//  WeatherReportManager.swift
//  Clima
//
//  Created by Mohamed Khalid on 18/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherReportManagerDelegate {
    func didUpdateWeatherReport(_ weatherReportManager: WeatherReportManager,weatherReport: WeatherReportData)
}

struct WeatherReportManager {
    let APIurl = "https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,minutely,hourly,alerts,current&appid=b95e81f1413bd5d89fb5af568d2fa70c&units=metric"
    var delegate: WeatherReportManagerDelegate?
    
    func performRequest(longitude: Double, latitude: Double) {
        guard let url = URL(string: "\(APIurl)&lon=\(longitude)&lat=\(latitude)") else { return }
        print(url)
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            if let safeData = data{
                let jsonDecoder = JSONDecoder()
                let decodedData = try! jsonDecoder.decode(WeatherReportData.self, from: safeData)
                DispatchQueue.main.async {
                    delegate?.didUpdateWeatherReport(self, weatherReport: decodedData)
                }
            } else {
                print(error!)
            }
        }
        task.resume()
        
        
        
    }
}
