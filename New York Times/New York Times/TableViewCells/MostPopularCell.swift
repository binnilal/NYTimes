//
//  MostPopularCell.swift
//  New York Times
//
//  Created by Binnilal on 28/07/2021.
//

import UIKit
import Kingfisher

class MostPopularCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setData(_ cellViewModel: PopularArticleCellViewModel) {
        
        // Setting image
        let url = URL(string: cellViewModel.imageUrl)
        let processor = DownsamplingImageProcessor(size: self.articleImageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 0)
        self.articleImageView.kf.indicatorType = .activity
        self.articleImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        self.abstractLabel.text   = cellViewModel.abstractText
        self.headingLabel.text    = cellViewModel.titleText
        self.imageTitleLabel.text = cellViewModel.imageCopyRight
        self.dateLabel.text = cellViewModel.dateText.monthAndDayFormat()
    }

}
