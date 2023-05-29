//
//  Coordinator.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 29/05/2023.
//

import UIKit


protocol Coordinator: AnyObject {
    func start()
    var childCoordinators: [Coordinator]? { get set }
    var navigationController: UINavigationController { get }
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

class MainCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator]?
    var navigationController: UINavigationController
    
    init(with nav: UINavigationController) {
        self.navigationController = nav
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        let vc = NewsListViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetails(viewModel: ArticleViewModelProtocol?) {
        guard let viewModel = viewModel else {
            assertionFailure("viewModel is nil")
            return
        }
        
        let vc = SelectedArticleDetailsViewController.instantiate(from: "Main")
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
}
