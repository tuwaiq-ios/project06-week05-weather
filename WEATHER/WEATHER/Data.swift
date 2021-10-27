//
//  Data.swift
//  WEATHER
//
//  Created by Tsnim Alqahtani on 20/03/1443 AH.
//

import UIKit



struct weatherAPI: Codable {
    var name: String
    var weather: Array<weather>
    var main: main
}

    struct weather: Codable {
        var main: String
        var description: String
        
    }

struct main: Codable {
    
    var humidity: Double
    var feels_like: Double
    
}
