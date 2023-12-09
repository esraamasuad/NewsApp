//
//  SearchList.swift
//  NewsApp
//
//  Created by Esraa on 08/12/2023.
//

import Foundation
import RealmSwift

//MARK: - Realm Model -

class SearchList: Object, ObjectKeyIdentifiable {
    @Persisted var query: String
    @Persisted var date: String
    @Persisted var articles: List<ArticleModel> = List<ArticleModel>()
    
    convenience init (query: String, articles: [ArticleModel]) {
        self.init()
        self.query = query
        let _ = articles.map {
            self.articles.append($0)
        }
    }
}

