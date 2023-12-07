//
//  DetailsView.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import SwiftUI

struct DetailsView: View {
    
    let article: ArticleModel

    var body: some View {
        Text(article.title ?? "")
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(article: ArticleModel())
    }
}
