//
//  HomeMapScreenCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class HomeMapCoordinator: Coordinator {
  
  unowned let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = HomeMapViewController()
    viewController.viewModel = HomeMapViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }

}
