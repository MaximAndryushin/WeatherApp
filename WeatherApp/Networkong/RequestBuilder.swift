//
//  RequestBuilder.swift
//  WeatherApp
//
//  Created by Maxim Andryushin on 23.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import Alamofire


//MARK: - Request Builder

protocol RequestBuilder: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
}

extension RequestBuilder {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch method {
        case .get:
            request.allHTTPHeaderFields = headers?.dictionary
            request = try URLEncoding.default.encode(request, with: parameters)
        default:
            break
        }
        
        return request
    }
}


//MARK: - Service request builder

enum TemperatureProvider: RequestBuilder {
    
    case getTemperature(lat: Double, lon: Double)
    case doSmth
    var baseURL: String {
        return "https://fcc-weather-api.glitch.me"
    }
    
    var path: String {
        return "/api/current"
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        switch  self {
        case .getTemperature(let lat, let lon):
            return [
                "lon": lon,
                "lat": lat
            ]
        default:
            return nil
        }
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
