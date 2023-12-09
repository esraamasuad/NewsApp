//
//  SearchView.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import SwiftUI
import RealmSwift

struct SearchView: View {
    
    @ObservedObject var vm: SearchViewModel
    @State private var query: String = ""
    @State private var isOffline: Bool = false
    @StateObject private var networkMonitor = NetworkMonitor()
    
    init(viewModel: SearchViewModel) {
        self.vm = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack {
                    TextField("search...", text: $query, onCommit: {
                        self.searchAction()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    if isOffline {
                        Text("Offline Mode \n No Internet Connection...")
                            .font(.caption)
                    }
                    
                    Group { () -> AnyView in
                        switch vm.uiState {
                        case .Init:
                            return AnyView(Text("Please type in to query"))
                            
                        case .Loading(let message):
                            return AnyView(Text(message))
                            
                        case .Fetched(let moviesResult):
                            return AnyView(NewsListView(result: moviesResult))
                            
                        case .NoResultsFound:
                            return AnyView(Text("No matching search found"))
                            
                        case .ApiError(let errorMessage):
                            return AnyView(Text(errorMessage))
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("News")
        }
        .onAppear {
            print("🔴 OnAppear")
            lastSearchResult()
        }
        .onDisappear { print("🔴 OnDisappear") }
    }
    
    /**
     - handle online & offline Searching Mode....
     */
    func searchAction() {
        guard !query.isEmpty else {return }
        if networkMonitor.isConnected {
            isOffline = false
            self.vm.loadMovies(query: self.query)
        } else {
            isOffline = true
            let result = vm.searchList.first(where: {$0.query.lowercased() == query.lowercased()})?.articles
            if let result = result {
                vm.uiState = .Fetched(NewsGeneralModel(articles: Array(result)))
            }else {
                vm.uiState = .NoResultsFound
            }
        }
    }
    
    /**
     - display the last search if Offline
     */
    func lastSearchResult() {
        if !networkMonitor.isConnected {
            if let result = vm.searchList.last {
                DispatchQueue.main.async { query = result.query}
                vm.uiState = .Fetched(NewsGeneralModel(articles: Array(result.articles)))
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}


