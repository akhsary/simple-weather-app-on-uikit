//
//  WeatherViewModel.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 19.05.2024.
//

import Foundation
import CoreLocation


final class WeatherViewModel: ObservableObject {
    
    private var locationService = LocationService.shared
    var weatherService = WeatherService.shared
    static var shared = WeatherViewModel()
    
    
    var onUserWeatherChange1: ((ResponseBody?)->())?
    var onUserWeatherChange2: ((ResponseBody?)->())?
    var onUserWeatherChange3: ((ResponseBody?)->())?
    var onUserWeatherChange4: ((ResponseBody?)->())?
    
    var userWeather: ResponseBody? {
        didSet {
            print("userWeatherChaned")
            onUserWeatherChange1?(userWeather)
            onUserWeatherChange2?(userWeather)
            onUserWeatherChange3?(userWeather)
            onUserWeatherChange4?(userWeather)
        }
    }
    var deafultCitiesArray: [ResponseBody] = []
    private let defaultCoordArray: [CLLocationCoordinate2D] =
        [
            CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6172),
            CLLocationCoordinate2D(latitude: 59.9375, longitude: 30.3086),
            CLLocationCoordinate2D(latitude: 55.0500, longitude: 82.9500),
            CLLocationCoordinate2D(latitude: 56.8356, longitude: 60.6128),
            CLLocationCoordinate2D(latitude: 55.7964, longitude: 49.1089),
            CLLocationCoordinate2D(latitude: 56.3269, longitude: 44.0075),
            CLLocationCoordinate2D(latitude: 45.0368, longitude: 35.3779),
            CLLocationCoordinate2D(latitude: 45.71168, longitude: 34.39274),
            CLLocationCoordinate2D(latitude: 44.9572, longitude: 34.1108)
        ]
    
    var error: String?
    
    func loadWeatherFor(_ location: CLLocationCoordinate2D, completion: @escaping (ResponseBody?) -> Void) {
        weatherService.fetchWeather(latitude: location.latitude, longitude: location.longitude) { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                self.error = failure.localizedDescription
                completion(nil)
            }
        }
    }
    
    func loadWeatherForDefaultCities() {
        defaultCoordArray.forEach { location in
            loadWeatherFor(location) { weatherData in
                if let weatherData = weatherData {
                    self.deafultCitiesArray.append(weatherData)
                }
            }
        }
    }
    
    private init() {
        locationService.checkIfLocationIsEnabled()
        if let location = locationService.location {
            loadWeatherFor(location) { [weak self] weatherData in
                self?.userWeather = weatherData
            }
        }
        loadWeatherForDefaultCities()
    }
}
