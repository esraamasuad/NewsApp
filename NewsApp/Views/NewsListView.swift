//
//  NewsListView.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import SwiftUI
import Kingfisher

struct NewsListView: View {
    
    let result: NewsGeneralModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(result.articles!, id: \.title) { article in
                    NavigationLink(destination: DetailsView(article: article)) {
                        ArticleView(article: article)
                    }
                }
            }
            .background(Color.clear)
        }
        .padding()
        .background(Color.clear)
    }
}


//struct NewsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsListView(movieResult: <#NewsGeneralModel#>)
//    }
//}

struct ArticleView: View {
    
    let article: ArticleModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            KFImage(URL(string: (article.urlToImage ?? "")))
                .resizable()
                .frame(height: 150)
                .cornerRadius(20)
            Text(article.title ?? "")
                .foregroundColor(AppColors.titleTextColor)
                .font(.subheadline)
            
            Text(article.source?.name ?? "")
                .foregroundColor(.gray)
                .lineLimit(1)
            
            Spacer()
        })
        .padding()
        .background(AppColors.cardBackgroundColor)
        .cornerRadius(20)
    }
}


