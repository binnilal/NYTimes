//
//  MostPopularViewModel.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import Foundation

protocol Loadable {
    var showLoading: (() -> Void)! { get set }
    var hideLoading: (() -> Void)! { get set }
}

protocol Alertable {
    var showSuccessAlert: ((_ title: String, _ message: String) -> Void)! { get set }
    var showFailureAlert: ((_ title: String, _ message: String) -> Void)! { get set }
}

class MostPopularViewModel: Loadable, Alertable {
    
    let apiService: APIProtocol!
    var showLoading: (() -> Void)!
    var hideLoading: (() -> Void)!
    var showSuccessAlert: ((String, String) -> Void)!
    var showFailureAlert: ((String, String) -> Void)!
    
    var articlesFetched: (() -> Void)!
    
    private var popularArticleCellViewModels: [PopularArticleCellViewModel] = []
    var pageIndex: Int = 1
    var selectedPopularDetail: PopularArticleDetailsViewModel?
    var errorMessage: String = ""
    
    init(apiService: APIProtocol = APIManager()) {
        self.apiService = apiService
    }
    
    var numberOfCells: Int {
        return popularArticleCellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath ) -> PopularArticleCellViewModel {
        return popularArticleCellViewModels[indexPath.row]
    }
    
    func getMostPopularArticles() {
        if self.pageIndex == 1 && !AppConfig.isRunningTests {
            self.showLoading()
        }
        apiService.getMostPopularArticles(self.pageIndex) { (isSuccess, message, popularArticleResponse) in
            if self.pageIndex == 1 && !AppConfig.isRunningTests {
                self.hideLoading()
            }
            if isSuccess, let response = popularArticleResponse, let mostPopularArticles = response.results {
                for article in mostPopularArticles {
                    self.popularArticleCellViewModels.append(self.createCellViewModel(popularArticle: article))
                }
                if !AppConfig.isRunningTests {
                    self.articlesFetched()
                }
            }
            self.errorMessage = message
            self.pageIndex += 1
        }
    }
    
    func createCellViewModel(popularArticle: MostPopularArticle) -> PopularArticleCellViewModel {
        var imageCopyRight = ""
        var imageURL = ""
        if let mediaArray = popularArticle.mediaList {
            let mediaFilterArray = mediaArray.filter{
                $0.type == "image"
            }
            
            if mediaFilterArray.count > 0 {
                imageCopyRight = mediaFilterArray[0].copyRight ?? ""
                
                if let mediaMetaData = mediaFilterArray[0].mediaDataList {
                    let metaDataArray = mediaMetaData.filter{
                        $0.width?.intValue ?? 0 > 240
                    }
                    imageURL = metaDataArray.count > 0 ? metaDataArray[0].url ?? "" : ""
                }
            }
        }
        
        let title = popularArticle.title ?? ""
        let abstract = popularArticle.abstract ?? ""
        let date = popularArticle.publishedDate ?? ""
        let webURL = popularArticle.webURL ?? ""
        
        return PopularArticleCellViewModel.init(imageUrl: imageURL, imageCopyRight: imageCopyRight, titleText: title, abstractText: abstract, dateText: date, webURL: webURL)
    }
}

extension MostPopularViewModel {
    func tappedPopularArticle(_ indexPath: IndexPath) {
        guard self.numberOfCells > indexPath.row else {
            return
        }
        guard popularArticleCellViewModels[indexPath.row].webURL != "" else {
            return
        }
        
        self.selectedPopularDetail = PopularArticleDetailsViewModel.init(webURL: popularArticleCellViewModels[indexPath.row].webURL)
        
    }
}

struct PopularArticleCellViewModel {
    let imageUrl: String
    let imageCopyRight: String
    let titleText: String
    let abstractText: String
    let dateText: String
    let webURL: String
}

struct PopularArticleDetailsViewModel {
    let webURL: String
}
