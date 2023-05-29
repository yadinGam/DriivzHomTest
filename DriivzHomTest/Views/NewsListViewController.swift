//
//  ViewController.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 29/05/2023.
//

import UIKit
import SDWebImage

class NewsListViewController: UIViewController, Storyborded {
    
    private var viewModel: NewsListViewModelProtocol = NewsListViewModel()
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var newsTableView: UITableView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.bindToModels()
        self.viewModel.fetchNews()
    }
    
    //MARK: Private Methods
    private func setupTableView() {
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        
        self.newsTableView.register(UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil), forCellReuseIdentifier:  String(describing: ArticleTableViewCell.self))
        self.newsTableView.rowHeight = UITableView.automaticDimension
        self.newsTableView.estimatedRowHeight = 100
        self.newsTableView.tableFooterView = UIView()
    }
    
    private func bindToModels() {
        self.viewModel.bindToItems(listener: { articles in
            DispatchQueue.main.async {
                [weak self] in
                self?.newsTableView.reloadData()
            }
        })
    }
    
    //MARK: Nevigations
    private func showSelectedArticleDetailsViewController(with viewModel: ArticleViewModelProtocol) {
        let selectedArticleDetailsViewController = SelectedArticleDetailsViewController.instantiate()
        selectedArticleDetailsViewController.viewModel = viewModel
        navigationController?.pushViewController(selectedArticleDetailsViewController, animated: true)
    }
    
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let _ = tableView.cellForRow(at: indexPath) as? ArticleTableViewCell,
              let viewModel = self.viewModel.item(for: indexPath.row) else {
            return
        }
        
        self.showSelectedArticleDetailsViewController(with: viewModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTableViewCell.self)) as? ArticleTableViewCell,
              let viewModel = self.viewModel.item(for: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        cell.configure(viewModel: viewModel)
        
        return cell
    }
    
}



