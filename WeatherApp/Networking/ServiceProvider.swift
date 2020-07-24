//
//  ServiceProvider.swift
//  WeatherApp
//
//  Created by Maxim Andryushin on 23.07.2020.
//  Copyright © 2020 Kirill+Maxim. All rights reserved.
//

import Alamofire


//MARK: - Result

enum Result<T: Codable> {
    case success(T)
    case failure(Error)
}


//MARK: - Service Provider

final class ServiceProvider<T: RequestBuilder> {
    
    func load<U: Codable>(service: T, decodeType: U.Type, completion: @escaping (Result<U>) -> ()) {
        guard let request = service.urlRequest else { return }
        AF.request(request).responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

