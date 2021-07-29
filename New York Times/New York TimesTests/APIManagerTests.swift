//
//  APIManagerTests.swift
//  New York TimesTests
//
//  Created by Binnilal on 29/07/2021.
//

import XCTest
@testable import New_York_Times

class APIManagerTests: XCTestCase {
    
    var apiService: APIManager!
    
    override func setUp() {
        apiService = APIManager()
    }
    
    override func tearDown() {
        apiService = nil
    }
    
    func test_popular_articles() {
        let expect = XCTestExpectation(description: "callback")
        
        apiService.getMostPopularArticles { (isSuccess, message, response) in
            expect.fulfill()
            
            XCTAssertTrue(isSuccess)
            XCTAssertNotNil(response)
            XCTAssertNotNil(response?.results)
            for popular in response?.results ?? [] {
                XCTAssertNotNil(popular)
            }
        }
        
        wait(for: [expect], timeout: 5.0)
    }
}
