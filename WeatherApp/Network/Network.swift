//
//  Network.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

class Network {
    
    class func request<T: Codable>(endpoint: Endpoint , completion: @escaping (Result<T,Error>) -> ()){
        var components = URLComponents()
        components.host = endpoint.baseURL
        components.path = endpoint.path
        
        guard let urlAsString = components.host , let url = URL(string: urlAsString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        switch endpoint.parameters {
        case .url(let items):
            var componentsWithQueryItems = URLComponents(string: url.appendingPathComponent(endpoint.path).absoluteString)
            componentsWithQueryItems?.queryItems = items
            urlRequest.url = componentsWithQueryItems?.url
        case .body(let params):
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = TimeInterval(20)
        config.timeoutIntervalForResource = TimeInterval(25)
        
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
         
            if let errorUrl = error as? URLError {
                if errorUrl.code == .timedOut {
                    completion(.failure(NSError(domain: WeatherError.timeOut.rawValue, code: -1, userInfo: nil)))
                    return
                }
            }
            
            if let error = error {
                completion(.failure(error))
            }
           
            guard response != nil, let data = data else { return }
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                    return
                }else{
                    completion(.failure(NSError(domain: WeatherError.failedDecode.rawValue, code: -1, userInfo: nil)))
                    return
                }
            }
        }
        dataTask.resume()
        
    }
}
