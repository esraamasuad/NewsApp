//
//  NewsGeneralModel.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import Foundation
import RealmSwift

// MARK: - GeneralModel
class NewsGeneralModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleModel]?
    
    init() {}
    
    init(articles: [ArticleModel]?) {
        self.articles = articles
    }
}

// MARK: - ArticleModel
class ArticleModel: Object, ObjectKeyIdentifiable, Codable {
    @Persisted var source: SourceModel?
    @Persisted var author: String?
    @Persisted var title: String?
    @Persisted var description_: String?
    @Persisted var url: String?
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String?
    @Persisted var content: String?
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description_ = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
    
    lazy var formatedDate: String = { () -> String in
        guard let originalDateString = publishedAt else {return ""}
      
        let originalFormat = DateFormatter()
        originalFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = originalFormat.date(from: originalDateString)
        
        let outputFormat = DateFormatter()
        outputFormat.dateFormat = "MM-dd-yyyy HH:mm"

        if let date = date {
            return outputFormat.string(from: date)
        }
        return ""
    }()
}

// MARK: - SourceModel
class SourceModel: Object, ObjectKeyIdentifiable, Codable {
    @Persisted var id: String?
    @Persisted var name: String?
}

enum MyError: Error {
    case runtimeError(String)
}
