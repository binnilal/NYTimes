//
//  MostPopularArticleResponse.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import Foundation
import ObjectMapper

class MostPopularArticleResponse: Mappable {
    var status: String?
    var results: [MostPopularArticle]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        status  <- map["status"]
        results <- map["results"]
    }
}

class MostPopularArticle: Mappable {
    var publishedDate: String?
    var title: String?
    var abstract: String?
    var webURL: String?
    var mediaList: [ArticleMedia]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        publishedDate <- map["published_date"]
        title     <- map["title"]
        abstract  <- map["abstract"]
        webURL    <- map["url"]
        mediaList <- map["media"]
    }
}

class ArticleMedia: Mappable {
    var type: String?
    var subType: String?
    var copyRight: String?
    var mediaDataList: [ArticleMediaMetaData]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        type    <- map["type"]
        subType <- map["subtype"]
        copyRight <- map["copyright"]
        mediaDataList <- map["media-metadata"]
    }
}

class ArticleMediaMetaData: Mappable {
    var url: String?
    var format: String?
    var height: NSNumber?
    var width: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        url    <- map["url"]
        format <- map["format"]
        height <- map["height"]
        width  <- map["width"]
    }
}
