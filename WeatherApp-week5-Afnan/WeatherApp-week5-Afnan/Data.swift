//
//  Data.swift
//  WeatherApp-week5-Afnan
//
//  Created by Fno Khalid on 20/03/1443 AH.
//

import UIKit


struct weatherAPI: Codable {
    var timezone: Double
    var name: String
    var weather: Array<weather>
    var main: main
    var sys: sys
}
 
   struct weather: Codable {
      // var id: Double
       var main: String
       var description: String
       var icon: String {
           
           return String(format: "%.1f", description)
         }
         var conditionName: String {
           switch icon {
           case "clear" :
             return "04d"
           case "cleary":
             return "02n"
           case "cloudy":
             return "05d"
           case "rainy":
             return "06d"
           case "snowy":
             return "04n"
           case "":
             return "01n"
           case "night":
             return "06d"
           default:
             return "01d"
           }
         }
}

struct sys: Codable {
    var country: String
}

   struct main: Codable {
       var humidity: Double
     var feels_like: Double
       
   }




 
