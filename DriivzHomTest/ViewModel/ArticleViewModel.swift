//
//  ArticleViewModel.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 28/05/2023.
//

import Foundation

protocol ArticleViewModelProtocol {
    var title: String? { get}
    var description: String? { get }
    var url: URL? { get }
}

class ArticleViewModel: ArticleViewModelProtocol {
    
    var title: String?
    var description: String?
    var url: URL?
    
    init(with article: Article) {
        self.title = article.title
        self.description = article.description
        if let link = article.link {
            self.url = URL(string: link)
        }
    }
}
