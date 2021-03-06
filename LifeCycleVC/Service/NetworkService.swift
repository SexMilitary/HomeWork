//
//  NetworkService.swift
//  LifeCycleVC
//
//  Created by Максим on 20.03.2021.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum BodyType {
    case json
    case formUrlencoded(array: [String: String])
}

public typealias Headers = [String: String]
public typealias UserData = [String: String]

protocol Networking {
    func request(url: URL, method: String, bodyType: BodyType, headers: Headers?, userData: JSONModel?, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {

    func request(url: URL, method: String, bodyType: BodyType, headers: Headers?, userData: JSONModel?, completion: @escaping (Data?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(key, forHTTPHeaderField: value)
            }
        }
        
        switch bodyType {
        
        case .json:
            if let userData = userData {
                do {
                    let httpBody = try JSONEncoder().encode(userData)
                    request.httpBody = httpBody
                } catch {
                    print(error)
                }
            }
        case .formUrlencoded(array: let params):
            // Лучше всего передавать “application/x-www-form-urlencoded” этим способом:
            var requestBodyComponents = URLComponents()
            
            requestBodyComponents.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
            request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        }
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from requst: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: requst, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
