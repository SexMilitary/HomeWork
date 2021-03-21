//
//  LocalDataFetcher.swift
//  LifeCycleVC
//
//  Created by Максим on 20.03.2021.
//

import Foundation

class LocalDataFetcher: NetworkDataFetcher {
    
    override func fetchGenericJSONData<T>(url: URL, response: @escaping (T?) -> Void) where T : Decodable {
        
        let urlString = try? String(contentsOf: url)
        
        guard let file = Bundle.main.url(forResource: urlString, withExtension: nil) else {
            print("Couldn't find \(String(describing: urlString)) in main bundle.")
            response(nil)
            return
        }
        
        let data = try? Data(contentsOf: file)
        
        let decoded = self.decodeJSON(type: T.self, from: data)
        response(decoded)
    }
    
}

