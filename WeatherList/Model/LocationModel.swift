//
//  CityModel.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/19.
//

import Foundation

struct Location: Codable {
    let title: String
    let locationType: String
    let woeid: Int
    let lattLong: String

    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}
