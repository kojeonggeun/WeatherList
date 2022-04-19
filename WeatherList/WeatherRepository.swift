//
//  Repository.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/19.
//

import Foundation

class WeatherRepository {
    
    private let network = WeatherNetwork(baseUrl: "https://www.metaweather.com/api/location")
    
    func woeIdList(city: String) {
        network.get(path: "/search/",
                           params: ["query": city]
        ) { result in
            if let json = try? result.get() {
                print(json.title)
                print(json.woeid)
            }
        }
    }
    
    
}
