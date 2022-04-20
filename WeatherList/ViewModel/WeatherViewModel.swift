//
//  ViewModel.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/18.
//

import Foundation
import RxSwift
import RxRelay

public protocol WeatherInput {
    func requestWeatherApi()
}

public protocol WeatherOutput {
    var weathers: Observable<Weather> { get }
    var activated: Observable<Bool> { get }
}

public protocol WeatherViewModelType {
    var inputs: WeatherInput { get }
    var outputs: WeatherOutput { get }
}

class WeatherViewModel: WeatherInput, WeatherOutput, WeatherViewModelType {
    private let _weathers = PublishRelay<Weather>()
    private let _activating = BehaviorSubject<Bool>(value: false)
    
    private let repository = WeatherRepository()
    private let disposeBag = DisposeBag()
    let cities = ["Seoul", "London", "Chicago"]
    
    var inputs: WeatherInput { return self }
    var outputs: WeatherOutput { return self }
    
    var weathers: Observable<Weather> {
        return _weathers.asObservable()
    }
    
    var activated: Observable<Bool> {
        return _activating.distinctUntilChanged()
    }
    
    func requestWeatherApi(){
        for i in cities{
            self.repository.locationList(city:i)
                .do(onNext: { _ in self._activating.onNext(true)})
                .flatMap{ data in self.repository.weatherList(woeid: data.woeid)}
                .subscribe(onNext: { result in
                    self._weathers.accept(result)
                    self._activating.onNext(false)
                }).disposed(by: self.disposeBag)
        }
    }
    
    
}
