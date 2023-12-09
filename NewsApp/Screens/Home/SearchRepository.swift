//
//  SearchRepository.swift
//  NewsApp
//
//  Created by Esraa on 06/12/2023.
//

import Foundation
import Alamofire
import RxSwift
import RealmSwift

class NewsRepository {
    
    @Default(\.isArabic) var isArabic

    func createRequest<T: Codable>(url: String) -> Observable<T> {
        
        let observable = Observable<T>.create { observer -> Disposable in
            Alamofire.request(url)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by alamofire return .notFound error instead.
                            // .notFound should never happen here?
                            observer.onError(response.error ?? MyError.runtimeError("random message"))
                            return
                        }
                        do {
                            let projects = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(projects)
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
        _ =  observable.observe(on: MainScheduler.instance)
        return observable
    }
    
    func searchQuery(query: String) -> Observable<NewsGeneralModel> {
        let language = isArabic ? "ar" : "en"
        
        let baseUrl = "https://newsapi.org/v2/everything?q=\(query)&from=2023-12-01&sortBy=publishedAt&page=1&pageSize=10&language=\(language)&apiKey=89a16c4aaba143c5993cbb3f1ac4e7a2"
        
        ///addingPercentEncoding to the link for search by arabic and multi spaces keyword
        let encodedUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? baseUrl
        
        return createRequest(url: encodedUrl)
    }
    
    func getCurrentData() -> String {
        let currentDate = Date()
        let outputFormat = DateFormatter()
        outputFormat.dateFormat = "yyyy-MM-dd"
        return outputFormat.string(from: currentDate)
    }
}
