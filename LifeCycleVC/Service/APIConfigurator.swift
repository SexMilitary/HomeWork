//
//  APIConfigurator.swift
//  LifeCycleVC
//
//  Created by Максим on 20.03.2021.
//

import Foundation

struct APIConfigurator {
    
    enum RequestEndpointPath: String, CaseIterable {
        case get = "/posts/1/comments"
        case post = "/posts"
        case patch = "/posts/1"
        case delete = "/posts/1/"
    }

    static let ApiKey = "3549eae0c44f498985d5e644ed90f962"

    static func urlForNewsQuery() -> URL? {
        var urlComponents = APIConfigurator.baseUrlComponentsForNewsRequest
        urlComponents.path = NewsPath.top.rawValue
        
        let serchQueryItem = URLQueryItem(name: "q", value: "tesla")
        let sortQueryItem = URLQueryItem(name: "sortBy", value: "publishedAt")
        let keyQueryItem = APIConfigurator.keyQueryItem

        urlComponents.queryItems = [ serchQueryItem, sortQueryItem, keyQueryItem ]
        return urlComponents.url
    }
    
    static func urlForTestRequest(ofType: RequestEndpointPath, params: [String: String] = [:]) -> URL? {
        var urlComponents = APIConfigurator.baseUrlComponentsForTestRequest
        
        switch ofType {
        case .get:
            urlComponents.path = RequestEndpointPath.get.rawValue
        case .post:
            urlComponents.path = RequestEndpointPath.post.rawValue
        case .patch:
            urlComponents.path = RequestEndpointPath.patch.rawValue
        case .delete:
            urlComponents.path = RequestEndpointPath.delete.rawValue
        }
        
        // Можно передавать “application/x-www-form-urlencoded” этим способом:
        urlComponents.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return urlComponents.url
    }

}

private extension APIConfigurator {
    
    enum NewsPath: String {
        case top = "/v2/everything"
    }

    static var baseUrlComponentsForNewsRequest: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"

        return urlComponents
    }
    
    static var baseUrlComponentsForTestRequest: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        return urlComponents
    }

    static var keyQueryItem: URLQueryItem {
        return URLQueryItem(name: "apiKey", value: ApiKey)
    }
}
