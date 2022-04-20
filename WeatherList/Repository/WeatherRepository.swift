//
//  Repository.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/19.
//

import Foundation
import RxSwift

class WeatherRepository {
    
    private let network = WeatherNetwork(baseUrl: "https://www.metaweather.com/api/location/")
    
    func locationList(city: String) -> Observable<Location> {
        return Observable.create { emitter in
            self.network.getLocation(path: "search",
                        params: ["query": city]) { result in
                switch result {
                case .success(let location):
                    emitter.onNext(location)
                    emitter.onCompleted()
                    
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    
    func weatherList(woeid: Int) -> Observable<Weather> {
        return Observable.create { emitter in
            self.network.getWeather(woeid: woeid) { result in
                switch result {
                case .success(let weather):
                    emitter.onNext(weather)
                    emitter.onCompleted()
                    
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
