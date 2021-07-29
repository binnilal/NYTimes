//
//  UIStoryboard+Extensions.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import UIKit

extension UIStoryboard {
    
    private static let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
    
    func mostPopularVC() -> MostPopularVC {
        return UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.mostPopularVC) as! MostPopularVC
    }
    
    func mostPopularDetailsVC() -> MostPopularDetailsVC {
        return UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.mostPopularDetailsVC) as! MostPopularDetailsVC
    }
    
}
