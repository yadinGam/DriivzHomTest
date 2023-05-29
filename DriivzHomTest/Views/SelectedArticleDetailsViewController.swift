//
//  SelectedArticleDetailsViewController.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 26/05/2023.
//

import UIKit
import SDWebImage

class SelectedArticleDetailsViewController: UIViewController, Storyborded {
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var viewModel: ArticleViewModelProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    private func setupUI() {
        guard let article = self.viewModel else {
            return
        }
        
        self.articleTitleLabel.text = article.title
        self.articleDescriptionLabel.text = article.description
        self.articleImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.articleImageView.sd_setImage(with: article.url)
    }
}
