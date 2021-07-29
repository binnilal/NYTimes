//
//  ListViewModelTest.swift
//  New York TimesTests
//
//  Created by Binnilal on 29/07/2021.
//

import XCTest
import ObjectMapper
@testable import New_York_Times

class ListViewModelTest: XCTestCase {
    
    var sut: MostPopularViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        
        mockAPIService = MockApiService()
        sut = MostPopularViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_most_popular_articles() {
        // Given
        mockAPIService.completeMostPopular = nil
        
        // When
        sut.getMostPopularArticles()
        
        // Assert
        XCTAssert(mockAPIService!.isFetchPopularArticlesCalled)
    }
    
    func test_fetch_most_popular_articles_fail() {
        // When
        sut.getMostPopularArticles()

        mockAPIService.fetchFail(message: "")

        // Sut should display predefined error message
        XCTAssertNil(mockAPIService.completeMostPopular)
        XCTAssertEqual(sut.errorMessage, "")
    }
    
    func test_get_cell_view_model() {
            
        goToFetchPopularArticleFinished()
        
        let indexPath = IndexPath(row: 1, section: 0)
        XCTAssertNotNil(mockAPIService.completeMostPopular)
        XCTAssertNotNil(mockAPIService.completeMostPopular?.results)
        let testPopularArticle = mockAPIService.completeMostPopular?.results?[indexPath.row]
        
        // When
        let vm = sut.getCellViewModel(at: indexPath)
        
        //Assert
        XCTAssertEqual( vm.titleText, testPopularArticle?.title)
        XCTAssertEqual( vm.abstractText, testPopularArticle?.abstract)
        XCTAssertEqual( vm.dateText, testPopularArticle?.publishedDate)

    }
}

extension ListViewModelTest {
    private func goToFetchPopularArticleFinished() {
        mockAPIService.completeMostPopular = MockDataGenerator().popularArticleResponse()
        sut.getMostPopularArticles()
        mockAPIService.fetchSuccess()
    }
}

class MockApiService: APIProtocol {
    
    var isFetchPopularArticlesCalled = false

    var completeMostPopular: MostPopularArticleResponse?
    var completeClosure: ((Bool, String, MostPopularArticleResponse?) -> ())!
    
    func getMostPopularArticles(_ page: Int, completed: @escaping (Bool, String, MostPopularArticleResponse?) -> Void) {
        isFetchPopularArticlesCalled = true
        completeClosure = completed
    }

    func fetchSuccess() {
        completeClosure(true, "Success", completeMostPopular )
    }
    
    func fetchFail(message: String) {
        completeMostPopular = nil
        completeClosure(false, message, nil)
    }
    
}

class MockDataGenerator {
    func popularArticleResponse() -> MostPopularArticleResponse? {
        let url = Bundle.main.url(forResource: "popular_article", withExtension: "json")!
//        let path = Bundle.main.path(forResource: "popular_article", ofType: "json")!
        let data = try! Data(contentsOf: url)
        let jsonString = String(data: data, encoding: .utf8)
        guard let mostPopularArticleResponse: MostPopularArticleResponse = Mapper<MostPopularArticleResponse>().map(JSONString: jsonString!) else {
            return nil
        }
        return mostPopularArticleResponse
    }
}
