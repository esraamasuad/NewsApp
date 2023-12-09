//
//  SearchViewModel.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import Foundation
import RxSwift
import RealmSwift
import SwiftUI

class SearchViewModel : ObservableObject {
    
    //MARK: - PROPERTIES
    @Published var uiState: SearchPageState = .Init
    @ObservedResults(SearchList.self) var searchList
    
    let repository: NewsRepository = NewsRepository()
    let disposableBag = DisposeBag()
    
    //MARK: - update View state
    func loadMovies(query: String) {
        self.uiState = .Loading("Loading for \(query)")
        repository
            .searchQuery(query: query)
            .subscribe(
                onNext: { [weak self] response in
                    debugPrint(response)
                    if (response.articles?.isEmpty ?? true) {
                        self?.uiState = .NoResultsFound
                    }else {
                        self?.uiState = .Fetched(response)
                        self?.updateCachedData(query: query, result: response)
                    }
                },
                onError: { error in
                    self.uiState = .ApiError("Results couldnot be fetched")
                    debugPrint(error)
                }
            )
            .disposed(by: disposableBag)
    }
    
    /**
     - update an exist search query result
     OR
     - Add new query
     */
    func updateCachedData(query: String, result: NewsGeneralModel) {
        DispatchQueue.main.async {
            do {
                let realm = try! Realm()
                let storedQueryResult = realm.objects(SearchList.self).first { searchList in
                    searchList.query.lowercased() == query.lowercased()
                }

                if let search_ = storedQueryResult {
                    try realm.write {
                        search_.query = query
                        search_.articles.removeAll()
                        search_.articles.append(objectsIn: result.articles ?? [])
                    }
                }else {
                    let result = SearchList(query: query, articles: result.articles!)
                    self.$searchList.append(result)
                }
            } catch {
                print("Unable to update existing rate in Realm")
            }
        }
    }
    
}

//MARK: - Search Page States
enum SearchPageState {
    case Init
    case Loading(String)
    case Fetched(NewsGeneralModel)
    case NoResultsFound
    case ApiError(String)
}

