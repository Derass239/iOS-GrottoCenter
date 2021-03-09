//
//  SearchScreenCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class SearchCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = SearchViewController(nibName: nil, bundle: nil)
    viewController.viewModel = SearchViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
