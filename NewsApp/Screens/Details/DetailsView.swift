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
            VStack(alignment: .leading, spacing: 20, content: {
                Text(article.title ?? "")
                    .foregroundColor(.black)
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
                Button(action: {
                    openURL(URL(string: article.url ?? "")!)
                }, label: {
                    VStack(alignment: .leading, spacing: 20, content: {
                        Text(article.description ?? "")
                            .foregroundColor(.black)
                            .font(.caption)
                        Text(article.content ?? "")
                            .font(.body)
                            .foregroundColor(.black)
                    })
                })
                Button("Read more...") {
                    openURL(URL(string: article.url ?? "")!)
                }
                
                //                Link("Read more...", destination: URL(string: article.url ?? "")!)
            })
            .padding()
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(article: ArticleModel())
    }
}
