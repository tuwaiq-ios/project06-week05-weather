//
//  Manager.swift
//  weather
//
//  Created by alanood on 21/03/1443 AH.
//

import Foundation


protocol ManagerDelegate {
    func didUpdateWeather(_ weatherManager: Manager, weather: Model)
    func didFailWithError(error: Error)
}

struct Manager {
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=f0e3185c3064f15174eb946aee37660b&units=metric"
    
    var delegate: ManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        HTTPRequest(with: urlString)
    }

    
    func HTTPRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> Model? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id          = decodedData.weather[0].id
            let temp        = decodedData.main.temp
            let name        = decodedData.name
            let description = decodedData.weather[0].description
            
            let weather     = Model(conditionId: id, cityName: name, temperature: temp, description: description)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
