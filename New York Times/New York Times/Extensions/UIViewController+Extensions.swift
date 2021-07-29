//
//  UIViewController+Extensions.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import UIKit

extension UIViewController {

    func startActivityIndicator(
        style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.large,
        location: CGPoint? = nil) {
        let loc = location ?? self.view.center
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: style)
            //Add the tag so we can find the view in order to remove it later

            activityIndicator.tag = 2000
            //Set the location

            activityIndicator.center = loc
            activityIndicator.hidesWhenStopped = true
            //Start animating and add the view

            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.view.subviews.filter(
            { $0.tag == 2000}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func presentAlert(withTitle title: String, message : String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                print("You've pressed OK Button")
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
      }
}
