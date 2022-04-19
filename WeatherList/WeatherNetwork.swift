//
//  Network.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/18.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case invalidRequest
    case jsonError
    case serverError
}


class WeatherNetwork {
    
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
        
    func get(path: String, params: [String: String], completed: @escaping (Result<Location, NetworkError>) -> Void) {
        var urlComponents = URLComponents(string: baseUrl + path)
        
        let query = params.map { URLQueryItem(name: $0.key, value: $0.value)}
        urlComponents?.queryItems = query
        
        guard let url = urlComponents?.url else {
            completed(.failure(.invalidRequest))
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completed(.failure(.serverError))
                return
            }

            guard let data = data else {
                completed(.failure(.unknown))
                return
            }

            do {
                let json = try JSONDecoder().decode([Location].self, from: data)
                DispatchQueue.main.async {
                    completed(.success(json[0]))
                }
            } catch let error{
                
                completed(.failure(.jsonError))
            }
        }).resume()
    }
}

