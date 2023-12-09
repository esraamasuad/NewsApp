//
//  SearchView.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import SwiftUI
import RealmSwift
import Foundation

struct SearchView: View {
    
    @ObservedObject var vm: SearchViewModel
    @State private var query: String = ""
    @State private var isOffline: Bool = false
    @StateObject private var networkMonitor = NetworkMonitor()
    
    @Default(\.isArabic) var isArabic
    @Default(\.isDarkMode) var isDarkMode
    
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
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    Group { () -> AnyView in
                        switch vm.uiState {
                        case .Init:
                            return AnyView(Text("Please type in to query"))
                            
                        case .Loading(_):
                            return AnyView(Text("Loading for \(query)"))
                            
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
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                    Button(action: {isDarkMode.toggle()}, label: {
                        Label("Dark", systemImage: isDarkMode ? "lightbulb.fill" : "lightbulb")
                    })
                    Button(action: {isArabic.toggle()}, label: {
                        Label("Language", systemImage: isArabic ? "t.bubble" : "t.bubble.fill")
                    })
                })
            })
            .navigationBarTitle("News")
        }
        .accentColor(AppColors.titleTextColor)
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        .environment(\.locale, Locale.init(identifier: isArabic ? "ar" : "en"))
        .environment(\.layoutDirection, isArabic ? .rightToLeft : .leftToRight)
        .onAppear {
            lastSearchResult()
        }
        .onDisappear {}
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

//MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
            .environment(\.locale, Locale.init(identifier: "ar"))
//            .colorScheme(.dark)
    }
}


