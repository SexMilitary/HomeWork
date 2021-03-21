//
//  JSONPlaceholderModel.swift
//  LifeCycleVC
//
//  Created by Максим on 21.03.2021.
//

import Foundation

struct JSONModel: Codable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
    
    static func getArray(from: JSONModel) -> [String: String] {
        return ["postId": "\(from.postId ?? 0)",
                "id": "\(from.id ?? 0)",
                "name": "\(from.name ?? "")",
                "email":"\(from.email ?? "")",
                "body": "\(from.body ?? "")"]
    }
}


