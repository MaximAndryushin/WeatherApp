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
    
    case getTemperatureByCoordinates(lat: Double, lon: Double)
    case getTemperature(city: String)
    case doSmth
    
    private var APPID: String {
        return "ed2774029f852baf983475a7878071a3"
    }
    
    enum temperatureMetric {
        static let celcius = "metric"
        static let kelvin = "default"
        static let fahrenheit = "imperial"
    }
    
    var baseURL: String {
        return "http://api.openweathermap.org"
    }
    
    var path: String {
        return "/data/2.5/weather"
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        switch  self {
        case .getTemperatureByCoordinates(let lat, let lon):
            return [
                "lon": lon,
                "lat": lat,
                "appid": APPID,
                "units": temperatureMetric.celcius
            ]
        case .getTemperature(let city):
            return [
                "appid": APPID,
                "q": city,
                "units": temperatureMetric.celcius
            ]
        default:
            return nil
        }
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
