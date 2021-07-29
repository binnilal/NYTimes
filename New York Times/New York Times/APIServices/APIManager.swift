//
//  APIManager.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import Foundation
import Alamofire
import ObjectMapper

protocol APIProtocol {
    func getMostPopularArticles(_ page: Int, completed: @escaping (_ isSucces: Bool, _ message: String, _ response: MostPopularArticleResponse?) -> Void)
}

class APIManager: APIProtocol {
    
    func getMostPopularArticles(_ page: Int = 1, completed: @escaping (_ isSucces: Bool, _ message: String, _ response: MostPopularArticleResponse?) -> Void) {
        
        let urlString = "\(Constants.API.baseURL)\(Constants.API.mostPopularPathComponent)\(page).json?api-key=\(Constants.API.APIKey)"
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
            switch response.result {
            case .failure(let error):

                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print(responseString)
                    completed(false, "REQUEST FAILED", nil)
                }
            case .success( _):
                guard let responseJSON = response.result.value as? [String: AnyObject] else {
                    completed(false, "INVALID JSON RESPONSE", nil)
                    return
                }
                guard let mostPopularArticleResponse: MostPopularArticleResponse = Mapper<MostPopularArticleResponse>().map(JSONObject: responseJSON) else {
                    completed(false, "Error mapping response", nil)
                    return
                }
                if let status = mostPopularArticleResponse.status, status == "OK" {
                    completed(true, "Success", mostPopularArticleResponse)
                } else {
                    completed(false, mostPopularArticleResponse.status ?? "Error", mostPopularArticleResponse)
                }
            }
        }
        
    }
}
