//
//  NewsGeneralModel.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import Foundation

// MARK: - GeneralModel
struct NewsGeneralModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleModel]?
}

// MARK: - ArticleModel
struct ArticleModel: Codable {
    var source: SourceModel?
    var author, title, description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

// MARK: - SourceModel
struct SourceModel: Codable {
    var id, name: String?
}

enum MyError: Error {
    case runtimeError(String)
}
