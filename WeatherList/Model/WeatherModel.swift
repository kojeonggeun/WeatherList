//
//  Model.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/18.
//

import Foundation

public struct Weather: Codable {
    var consolidatedWeather: [ConsolidatedWeather]
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case title
    }
}

struct ConsolidatedWeather: Codable {
    let id: Int
    let weatherStateName: String
    let weatherStateAbbr: String
    let windDirectionCompass: String
    let created: String
    var applicableDate: String
    let minTemp: Double
    let maxTemp: Double
    let theTemp: Double
    let windSpeed: Double
    let windDirection: Double
    let airPressure: Double
    let humidity: Int
    let visibility: Double
    let predictability: Int

    enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case windDirectionCompass = "wind_direction_compass"
        case created
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case airPressure = "air_pressure"
        case humidity, visibility, predictability
    }
    
    mutating func updateApplicableDate(date:String){
        self.applicableDate = date
    }
}
