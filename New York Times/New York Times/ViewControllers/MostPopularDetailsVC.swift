//
//  MostPopularDetailsVC.swift
//  New York Times
//
//  Created by Binnilal on 29/07/2021.
//

import UIKit
import WebKit

class MostPopularDetailsVC: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    var popularDetailViewModel: PopularArticleDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadWebviewUrl()
    }
    

    func loadWebviewUrl()  {
        self.webview.navigationDelegate = self
        self.startActivityIndicator()
        let url = URL(string: self.popularDetailViewModel.webURL)
        self.webview.load(URLRequest(url: url!))
    }
    
    
}

extension MostPopularDetailsVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.stopActivityIndicator()
    }
}
