//
//  SearchView_Test.swift
//  NewsAppTests
//
//  Created by Esraa on 09/12/2023.
//

import XCTest
@testable import NewsApp

class SearchView_Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_SearchView_isCurrentLanguageNotArabic() {
        //Given
        let isArbic = false
        
        //when
       let view = SearchView(viewModel: SearchViewModel())
              
        //then
        XCTAssertEqual(view.isArabic, isArbic)
    }
    
    func test_SearchView_isOnlineMode() {
        //Given
        let isOnline = true
        
        //when
        let networkMonitor = NetworkMonitor()
        
        //then
        XCTAssertEqual(networkMonitor.isConnected, isOnline)
    }
}
