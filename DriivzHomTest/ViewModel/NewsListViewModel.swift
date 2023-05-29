//
//  NewsListViewModel.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 26/05/2023.
//

import Foundation

typealias UpdateArticlesListener = ([Article]) -> ()

protocol NewsListViewModelProtocol {
    var numberOfItems: Int { get }
    func bindToItems(listener: @escaping UpdateArticlesListener)
    func item(for index: Int) -> ArticleViewModelProtocol?
    func fetchNews()
}

class NewsListViewModel: NewsListViewModelProtocol {
    
    private var items: Box<[Article]>? = Box([])
    
    var numberOfItems: Int {
        return self.items?.value.count ?? 0
    }
    
    func bindToItems(listener: @escaping UpdateArticlesListener) {
        self.items?.bind(listener: listener)
    }
    
    func item(for index: Int) -> ArticleViewModelProtocol? {
        guard let items = self.items, !items.value.isEmpty else {
            return nil
        }
        
        return ArticleViewModel(with: items.value[index])
    }
    
    func fetchNews() {
        NASAImageOfTheDayParser.shared().parseRSSFeed { result in
            switch result {
            case .success(let items):
                self.items?.value = items
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
