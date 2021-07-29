//
//  MostPopularVC.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import UIKit
import UIScrollView_InfiniteScroll
import SkeletonView

class MostPopularVC: UIViewController {

    @IBOutlet weak var mostPopularArticleTableView: UITableView!
    
    lazy var viewModel: MostPopularViewModel = {
        return MostPopularViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mostPopularArticleTableView.rowHeight = UITableView.automaticDimension
        self.mostPopularArticleTableView.estimatedRowHeight  = 348.0
        
        self.title = "Most Popular"
        self.initializeViewModel()
    }
    
    fileprivate func initializeViewModel() {
        self.viewModel.showLoading = {[weak self] () in
            DispatchQueue.main.async {
                self?.mostPopularArticleTableView.showAnimatedSkeleton()
            }
        }
        self.viewModel.hideLoading = {[weak self] () in
            DispatchQueue.main.async {
                self?.mostPopularArticleTableView.hideSkeleton(transition: .crossDissolve(0.5))
            }
        }
        self.viewModel.showFailureAlert = {title, message in
            DispatchQueue.main.async {
                self.presentAlert(withTitle: title, message: message)
            }
        }
        self.viewModel.articlesFetched = {
            DispatchQueue.main.async {
                self.mostPopularArticleTableView.reloadData()
                self.mostPopularArticleTableView.finishInfiniteScroll()
            }
        }
        
        self.mostPopularArticleTableView.infiniteScrollIndicatorMargin = 10
        self.mostPopularArticleTableView.infiniteScrollTriggerOffset = 200
        self.mostPopularArticleTableView.addInfiniteScroll { [weak self] (tableView) -> Void in
            self?.viewModel.getMostPopularArticles()
        }
        self.mostPopularArticleTableView.beginInfiniteScroll(true)
        
        self.mostPopularArticleTableView.setShouldShowInfiniteScrollHandler { (tableView) -> Bool in
            return self.viewModel.pageIndex != 30
        }
    }


}

extension MostPopularVC: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "MostPopularSkeletonCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.mostPopularCell) as! MostPopularCell
        
        let cellViewModel = self.viewModel.getCellViewModel(at: indexPath)
        cell.setData(cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.viewModel.tappedPopularArticle(indexPath)
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detaisVC = UIStoryboard().mostPopularDetailsVC()
        detaisVC.popularDetailViewModel = self.viewModel.selectedPopularDetail
        self.navigationController?.pushViewController(detaisVC, animated: true)
    }
}

