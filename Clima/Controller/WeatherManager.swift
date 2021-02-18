//
//  WeatherManager.swift
//  Clima
//
//  Created by Mohamed Khalid on 17/02/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=b95e81f1413bd5d89fb5af568d2fa70c&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(withCityName cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        requestWeather(with: urlString)
    }
    func fetchWeather(withLatitude latitude: CLLocationDegrees, andLongitude longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        requestWeather(with: urlString)
    }
    
    func requestWeather(with url: String){
        // 1. Create URL
        guard let url = URL(string: url) else { return }
        // 2. Create URLSession
        let session = URLSession(configuration: .default)
        // 3. Give task to URL
        let task = session.dataTask(with: url) {(data, response, error) in
            if let safeData = data {
                if let weather = parseJSON(safeData){
                    delegate?.didUpdateWeather(self, weather:  weather)
                }
                if let safeError = error{
                    delegate?.didFailWithError(self, error: safeError)
                }
            }
        }
        // 4. Start task
        task.resume()
    }

    func parseJSON (_ jsonData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let weatherData = try decoder.decode(WeatherData.self, from: jsonData)
            let weather = WeatherModel(cityName: weatherData.name, weatherID: weatherData.weather[0].id, temperature: weatherData.main.temp, description: weatherData.weather[0].description, humidity: weatherData.main.humidity, latitude: weatherData.coord.lat, longitude: weatherData.coord.lon)
            return weather
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }

}
