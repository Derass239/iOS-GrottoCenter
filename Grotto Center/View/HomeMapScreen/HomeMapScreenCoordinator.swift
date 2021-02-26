//
//  HomeMapScreenCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class HomeMapScreenCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = HomeMapScreenViewController(nibName: nil, bundle: nil)
    viewController.viewModel = HomeMapScreenViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
