//
//  data.swift
//  weather
//
//  Created by alanood on 21/03/1443 AH.
//

import UIKit

struct WeatherData: Codable {
    let name        : String
    let main        : Main
    let weather     : [Weather]
}

struct Main: Codable {
    let temp        : Double
}

struct Weather: Codable {
    let description : String
    let id          : Int
}


struct Model {
    let conditionId : Int
    let cityName    : String
    let temperature : Double
    let description : String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
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

