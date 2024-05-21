//
//  WeatherService.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 19.05.2024.
//

import Foundation
import Alamofire
import CoreLocation

private let key = "b522a2d63414c8b37c1c262907b47a4d" 

final class WeatherService {
    static var shared = WeatherService()
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, complition: @escaping (Result<ResponseBody,APIError>) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)&units=metric"
        
        AF.request(url)
            .validate()
            .responseData { response in
                if let error = response.error { complition(Result.failure(.invalidStatusCode(error: error)))
                }
            }
            .response { response in
                guard let data = response.data else {
                    guard let error = response.error else {
                        return
                    }
                    complition(Result.failure(.unknownError(error: error)))
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(ResponseBody.self, from: data)
                    complition(Result.success(decodedData))
                } catch {
                    complition(Result.failure(.jsonParsingFailure))
                }
                
            }
    }
    private init(){}
}
