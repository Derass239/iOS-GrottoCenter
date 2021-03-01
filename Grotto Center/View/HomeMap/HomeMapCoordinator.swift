//
//  HomeMapScreenCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class HomeMapCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = HomeMapViewController(nibName: nil, bundle: nil)
    viewController.viewModel = HomeMapViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
