//
//  AppCoordinator.swift
//  Search (MVVM-C)
//
//  Created by Yegor Niedov on 19.12.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSearch()
    }
    
    func showSearch() {
        let vc = SearchViewController.createObject()
        vc.coordinator = self
        vc.viewModel = SearchViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMain(brandNmae: String) {
        let vc = MainViewController.createObject()
        let viewModel = MainViewModel()
        viewModel.barandName = brandNmae
        vc.coordinator = self
        vc.viewModel = viewModel
        //navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showDetail() {
        
    }
}
