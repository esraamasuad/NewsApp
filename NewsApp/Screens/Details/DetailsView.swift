//
//  DetailsView.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    
    @Environment(\.openURL) var openURL
    let article: ArticleModel
    
    var body: some View {
        ScrollView {
            Link(destination: URL(string: article.url ?? "")!) {
                VStack(alignment: .leading, spacing: 20, content: {
                    Text(article.title ?? "")
                        .foregroundColor(AppColors.titleTextColor)
                        .font(.largeTitle)
                        .lineLimit(nil)
                    KFImage(URL(string: (article.urlToImage ?? "")))
                        .resizable()
                        .frame(height: 250)
                        .cornerRadius(20)
                    Text(article.author ?? "")
                        .foregroundColor(.gray)
                    Text(article.source?.name ?? "")
                        .foregroundColor(.gray)
                    Text(article.description_ ?? "")
                        .lineLimit(nil)
                        .foregroundColor(AppColors.titleTextColor)
                        .font(.caption)
                    Text(article.content ?? "")
                        .lineLimit(nil)
                        .font(.body)
                        .foregroundColor(AppColors.titleTextColor)
                    Button("Read more...") {
                        openURL(URL(string: article.url ?? "")!)
                    }
                })
                .padding()
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(article: ArticleModel())
    }
}
