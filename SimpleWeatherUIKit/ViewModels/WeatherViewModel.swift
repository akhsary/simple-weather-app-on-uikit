//
//  WeatherViewModel.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 19.05.2024.
//

import Foundation
import CoreLocation
import Observation

final class WeatherViewModel {
    static let shared = WeatherService()
    
    var locationService = LocationService.shared
    var weatherService = WeatherService.shared
    
    var userWeather: ResponseBody?
    var deafultCitiesArray: [ResponseBody] = []
    var defaultCoordArray: [CLLocationCoordinate2D] {
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
    }
    
    var error: String?
    
    func loadWeatherFor(_ location: CLLocationCoordinate2D) -> ResponseBody? {
        var data: ResponseBody?
        weatherService.fetchWeather(latitude: location.latitude, longitude: location.longitude) { result in
            switch result {
            case .success(let success):
                data = success
            case .failure(let failure):
                self.error = failure.localizedDescription
            }
        }
        return data
    }
    
    func loadWeatherForDefaultCities(){
        defaultCoordArray.enumerated().forEach { index, location in
            if let weatherForCurrentCity = loadWeatherFor(location) {
                self.deafultCitiesArray[index] = weatherForCurrentCity
            }
        }
    }
    
    init(userWeather: ResponseBody? = nil, deafultCitiesArray: [ResponseBody] = [], error: String? = nil) {
        self.userWeather = userWeather
        self.deafultCitiesArray = deafultCitiesArray
        self.error = error
        self.deafultCitiesArray = deafultCitiesArray
        locationService.checkIfLocationIsEnabled()
        if let location = locationService.location {
            self.userWeather = loadWeatherFor(location)
        }
    }
    
}
