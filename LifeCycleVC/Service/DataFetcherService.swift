//
//  DataFetcherService.swift
//  LifeCycleVC
//
//  Created by Максим on 20.03.2021.
//

import Foundation

public enum ContentType {
    case json
    case urlencoded
}

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    var localDataFetcher: DataFetcher
    
    let data1 = JSONModel(postId: 12,
                         id: 12,
                         name: "Anna",
                         email: "anna@gmail.com",
                         body: "Body!")
    let data2 = JSONModel(postId: 12,
                         id: 12,
                         name: "Maxim",
                         email: "maxim@gmail.com",
                         body: "Body!")
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher(), localDataFetcher: DataFetcher = LocalDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
        self.localDataFetcher = localDataFetcher
    }
    
    func fetchNews(completion: @escaping (NewsModel?) -> Void) {
        guard let url = APIConfigurator.urlForNewsQuery() else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, response: completion)
    }
    
    func fetchGetRequestTest( completion: @escaping ([JSONModel]?) -> Void) {

        guard let url = APIConfigurator.urlForTestRequest(ofType: .get) else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, response: completion)
    }
    
    func fetchPostRequestTest(contentType: ContentType, completion: @escaping (JSONModel?) -> Void) {
        var url: URL!
        var header = [String: String]()
        
        switch contentType {

        case .json:
            url = APIConfigurator.urlForTestRequest(ofType: .post)
            header["application/json"] = "Content-Type"
            networkDataFetcher.uploadJSONData(url: url,
                                              headers: header,
                                              method: .post,
                                              bodyType: .json,
                                              userData: data1,
                                              response: completion)
        case .urlencoded:
            url = APIConfigurator.urlForTestRequest(ofType: .post)
            let params = ["id": "1", "name": "Max"]
            header["application/x-www-form-urlencoded"] = "Content-Type"
            networkDataFetcher.uploadJSONData(url: url,
                                              headers: header,
                                              method: .post,
                                              bodyType: .formUrlencoded(array: params),
                                              userData: nil,
                                              response: completion)
        }
        
    }
    
    func fetchPatchRequestTest(completion: @escaping (JSONModel?) -> Void) {
        
        guard let url = APIConfigurator.urlForTestRequest(ofType: .patch) else { return }
        
        networkDataFetcher.uploadJSONData(url: url,
                                          headers: ["application/json": "Content-Type"],
                                          method: .patch,
                                          bodyType: .json,
                                          userData: data2,
                                          response: completion)
    }
    
    func delPatchRequestTest(completion: @escaping (JSONModel?) -> Void) {
        guard let url = APIConfigurator.urlForTestRequest(ofType: .delete) else { return }
        networkDataFetcher.uploadJSONData(url: url,
                                          headers: ["application/json": "Content-Type"],
                                          method: .delete,
                                          bodyType: .json,
                                          userData: data2,
                                          response: completion)
    }
}
