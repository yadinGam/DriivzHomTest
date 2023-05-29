//
//  ArticleTableViewCell.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 26/05/2023.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemImageView?.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(viewModel: ArticleViewModelProtocol) {
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.itemImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.itemImageView.sd_setImage(with: viewModel.url)
    }
    
}
