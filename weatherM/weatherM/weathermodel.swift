//
//  weathermodel.swift
//  weatherM
//
//  Created by PC on 21/03/1443 AH.
//

import Foundation

// send to server -> Encodable
// read from server -> Decodable
// send & read -> Codable

struct WeatherData : Codable {
    let weather : [Weather]?
    let sys : Country?
    let name : String?
    let main : Main?
}

struct Weather : Codable {
    let description : String?
}

struct Country : Codable {
    let country : String?
}

struct Main : Codable {
    let temp : Double?
}

