//
//  wethardata.swift
//  The Wethar
//
//  Created by sara al zhrani on 20/03/1443 AH.
//

import UIKit

struct Weather: Codable{
 let name : String
 let main : Main
 let weather: Array<weather>
}
struct Main:Codable {
 let temp : Double
 let humidity : Int
}
struct weather:Codable {
 let main : String
 let description : String
//  let icon : String
}



struct WeatherModel {
  let conditionId: Int
  let cityName: String
  let temperature: Double
    
    
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
      }
      var conditionName: String {
        switch conditionId {
        case 200...232:
          return " "
        case 300...321:
          return " "
        case 500...531:
          return " "
        case 600...622:
          return " "
        case 701...781:
          return ""
        case 800:
          return " "
        case 801...804:
          return ""
        default:
          return " "
        }
      }
    }

