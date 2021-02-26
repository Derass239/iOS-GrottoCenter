//
//  SearchScreenCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class SearchScreenCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = SearchScreenViewController(nibName: nil, bundle: nil)
    viewController.viewModel = SearchScreenViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
