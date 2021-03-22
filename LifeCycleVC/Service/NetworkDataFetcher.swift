//
//  NetworkDataFetcher.swift
//  LifeCycleVC
//
//  Created by Максим on 20.03.2021.
//

import UIKit

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(url: URL, response: @escaping (T?) -> Void)
    func uploadJSONData(url: URL, headers: Headers?, method: HTTPMethod, bodyType: BodyType, userData: JSONModel?, response: @escaping (JSONModel?) -> Void)
}

class NetworkDataFetcher: DataFetcher {

    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(url: URL, response: @escaping (T?) -> Void) {
        networking.request(url: url, method: HTTPMethod.get.rawValue, bodyType: .json, headers: nil, userData: nil) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }

            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
    
    func uploadJSONData(url: URL, headers: Headers?, method: HTTPMethod, bodyType: BodyType, userData: JSONModel?, response: @escaping (JSONModel?) -> Void) {
        
        networking.request(url: url, method: method.rawValue, bodyType: bodyType, headers: headers, userData: userData) { (data, error) in
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            
            let decoded = self.decodeJSON(type: JSONModel.self, from: data)
            response(decoded)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        networking.request(url: url, method: HTTPMethod.get.rawValue, bodyType: .json, headers: nil, userData: nil) { (data, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            }
        }
    }
}
