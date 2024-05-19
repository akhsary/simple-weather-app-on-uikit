//
//  APIErrorModel.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 19.05.2024.
//

import Foundation
import Alamofire

enum APIError: Error {
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(error: AFError)
    case unknownError(error: AFError)
    
    var customDescription: String {
        switch self {
        case .jsonParsingFailure: return "Failed to parse JSON"
        case let .requestFailed(description): return "Request failed: \(description)"
        case let .invalidStatusCode(error): return "Invalid status code: \(error.localizedDescription)"
        case let .unknownError(error): return "An unknown eror occured: \(error.localizedDescription)"
        }
    }
}
