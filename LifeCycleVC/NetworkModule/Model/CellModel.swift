//
//  CellModel.swift
//  LifeCycleVC
//
//  Created by Максим on 20.03.2021.
//

import Foundation

struct CellModel: NetworkCellView {
    
    var iconUrlString: String
    var title: String
    var description: String
    
    static func getArticle(from newsJSON: NewsModel) -> [NetworkCellView]? {
        
        guard let articlesJSON = newsJSON.articles else { return nil }
        
        var articlesHadline = [CellModel]()
        for article in articlesJSON {
            articlesHadline.append(CellModel(iconUrlString: article.urlToImage ?? "Without image",
                                             title: article.title ?? "Empty title",
                                             description: article.description ?? "Empty description"))
        }
        
        return articlesHadline
        
    }
}
