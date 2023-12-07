//
//  SearchViewModel.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import Foundation
import RxSwift

class SearchViewModel : ObservableObject {
    
    @Published var uiState: SearchPageState = .Init
    
    let disposableBag = DisposeBag()
    
    let repository: MovieRepository = MovieRepository()
    
    func loadMovies(query: String) {
        
        self.uiState = .Loading("Loading for \(query)")
        repository
            .searchMovies(query: query)
            .subscribe(
                onNext: { [weak self] response in
                    debugPrint(response)
                    self?.uiState = (response.articles?.isEmpty ?? true) ?
                        .NoResultsFound : .Fetched(response)
                },
                onError: { error in
                    self.uiState = .ApiError("Results couldnot be fetched")
                    debugPrint(error)
            }
        )
            .disposed(by: disposableBag)
    }
}

enum SearchPageState {
    case Init
    case Loading(String)
    case Fetched(NewsGeneralModel)
    case NoResultsFound
    case ApiError(String)
}

