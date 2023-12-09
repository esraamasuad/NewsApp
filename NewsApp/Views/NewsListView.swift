//
//  NewsListView.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import SwiftUI
import Kingfisher

struct NewsListView: View {
    
    //MARK: - PROPERTIES
    let result: NewsGeneralModel
    
    //MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(result.articles!, id: \.title) { article in
                    NavigationLink(destination: DetailsView(article: article)) {
                        ArticleView(article: article)
                    }
                }
                Spacer()
                    .frame(height: 40)
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
    
    //MARK: - PROPERTIES
    let article: ArticleModel
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            HStack {
                Spacer()
                KFImage(URL(string: (article.urlToImage ?? "")))
                    .resizable()
                    .frame(height: 150)
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Text(article.title ?? "")
                .foregroundColor(AppColors.titleTextColor)
                .font(.subheadline)
            
            Text(article.source?.name ?? "")
                .foregroundColor(.gray)
                .lineLimit(1)
            
//            Spacer()
        })
        .padding()
        .background(AppColors.cardBackgroundColor)
        .cornerRadius(20)
    }
}


