//
//  AlamofireNetworkRequest.swift
//  LifeCycleVC
//
//  Created by Максим on 21.03.2021.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [NewsModel])->()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
            
            case .success(_):
                let courses = [NewsModel]()
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func downloadImage(url: String, completon: @escaping (_ image: UIImage) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url).responseData { (responseData) in
            
            switch responseData.result {
            
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completon(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responseData(url: String) {
        
        AF.request(url).responseData { (responseData) in
            
            switch responseData.result {
            
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responseString(url: String) {
        
        AF.request(url).responseString { (responseString) in
            
            switch responseString.result {
            
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func response(url: String) {
        
        AF.request(url).response { (response) in
            
            guard
                let data = response.data,
                let string = String(data: data, encoding: .utf8)
                else { return }
            
            print(string)
        }
    }
    
    static func downloadImageWithProgress(url: String, completon: @escaping (_ image: UIImage) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url).validate().downloadProgress { (progress) in
            
            print("totalUnitCount: \(progress.totalUnitCount)\n")
            print("completedUnitCount:\(progress.completedUnitCount)\n")
            print("fractionCompleted:\(progress.fractionCompleted)\n")
            print("loclizedDescription:\(progress.localizedDescription!)\n")
            print("---------------------------------------------------------")
            
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
                
        }.response { (response) in
            
            guard let data = response.data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                completon(image)
            }
        }
    } //func downloadImageWithProgress
    
    static func postRequest(url: String, completion: @escaping (_ courses: [JSONModel])->()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [String: Any] = ["name": "Network Requests"]
        
        AF.request(url, method: .post, parameters: userData).responseJSON { (responseJSON) in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print(statusCode)
            
            switch responseJSON.result {
            
            case .success(let value):
                print(value)
                
                guard value is [String: Any]
                else { return }
                
                let model = JSONModel(postId: 0, id: 0, name: "", email: "", body: "")
                var models = [JSONModel]()
                models.append(model)
                
                completion(models)
                
            case .failure(let error):
                print(error)
            }
        }
    } // func postRequest
    
    static func putRequest(url: String, completion: @escaping (_ courses: [JSONModel])->()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [String: Any] = ["name": "Network Requests with Alamo",
                                       "link": "https://swiftbook.ru/contents/our-first-applications/",
                                       "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
                                       "numberOfLessons": 18,
                                       "numberOfTests": 10]
        
        AF.request(url, method: .put, parameters: userData).responseJSON { (responseJSON) in
            
            guard let statusCode = responseJSON.response?.statusCode else { return }
            print(statusCode)
            
            switch responseJSON.result {
            
            case .success(let value):
                print(value)
                
                guard let _ = value as? [String: Any]
                else { return }
                
                let models = [JSONModel]()
                
                completion(models)
                
            case .failure(let error):
                print(error)
            }
        }
    } // func putRequest
    
    static func uploadImage(url: String) {
        
        guard let url = URL(string: url),
              let image = UIImage(named: ""),
              let data = image.pngData()
        else { return }
        
        let httpHeaders: HTTPHeaders = ["Authorization": "Client-ID 1bd22b9ce396a4c"]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: "image")
            
        }, to: url,
        method: .post,
        headers: httpHeaders).responseJSON { (response) in
            
            switch response.result {
            
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error)
            }
        }.uploadProgress { (progress) in
            print("totalUnitCount: \(progress.totalUnitCount)\n")
            print("completedUnitCount:\(progress.completedUnitCount)\n")
            print("fractionCompleted:\(progress.fractionCompleted)\n")
            print("loclizedDescription:\(progress.localizedDescription!)\n")
            print("---------------------------------------------------------")
        }
        
    } // func uploadImage
    
}


// Notes:


//            Validation
//            guard let statusCode = response.response?.statusCode else { return }
//            print(statusCode)
//
//            if (200..<300).contains(statusCode) {
//                guard let value = response.value else { return }
//                print(value)
//            } else {
//                guard let error = response.error else { return }
//                print(error)
//            }
