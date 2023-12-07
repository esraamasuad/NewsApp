//
//  SearchView.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import SwiftUI

struct SearchView: View {
   
    @ObservedObject var vm: SearchViewModel
    
    @State private var query: String = ""
    
    init(viewModel: SearchViewModel) {
        self.vm = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack {
                    TextField("search...", text: $query, onCommit: {
                        self.vm.loadMovies(query: self.query)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    Group { () -> AnyView in
                        switch vm.uiState {
                        case .Init:
                            return AnyView(Text("Please type in to query"))
                            
                        case .Loading(let message):
                            return AnyView(Text(message))
                            
                        case .Fetched(let moviesResult):
                            return AnyView(NewsListView(result: moviesResult))
                            
                        case .NoResultsFound:
                            return AnyView(Text("No matching movies found"))
                            
                        case .ApiError(let errorMessage):
                            return AnyView(Text(errorMessage))
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("News")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}


