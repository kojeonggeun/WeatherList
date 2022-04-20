//
//  WeatherManager.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/20.
//
import Foundation

class WeatherManager {
    private var _weathers: [Weather] = []
    var weathers: [Weather] {
        get {
            return _weathers
        }
    }
    static let cities: [String] = ["Seoul","London","Chicago"]
    
    func add(weather: Weather){
        _weathers.append(weather)
    }
    
    func descOrdering(){
        self._weathers = self._weathers.sorted(by: {$0.title > $1.title})
        
    }
    
    func isRequestCompleted() -> Bool{
        return self._weathers.count == WeatherManager.cities.count
    }
    
    func updateApplicationDate(){
        for i in 0..<self.weathers.count {
            
            self._weathers[i].consolidatedWeather[0].applicableDate = "Today"
            self._weathers[i].consolidatedWeather[1].applicableDate = "Tomorrow"

            for j in 2..<self.weathers[i].consolidatedWeather.count{
                
                if let date = self._weathers[i].consolidatedWeather[j].applicableDate.toDate() {
                    self._weathers[i].consolidatedWeather[j].applicableDate = date.toString()
                }
                
            }
        }
            
    }
}
