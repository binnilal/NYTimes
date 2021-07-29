//
//  Constants.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import Foundation

struct Constants {
    
    struct CellIdentifier {
        static let mostPopularCell = "MostPopularCell"
    }
    
    struct ViewControllerIdentifier {
        static let mostPopularVC = "MostPopularVC"
        static let mostPopularDetailsVC = "MostPopularDetailsVC"
    }
    
    struct API {
        static let APIKey = "X9pCyb6o0SREIwfUzdTPn8G41OTHeMJP"
        static let baseURL = "https://api.nytimes.com/svc"
        static let mostPopularPathComponent = "/mostpopular/v2/viewed/"
    }
}
