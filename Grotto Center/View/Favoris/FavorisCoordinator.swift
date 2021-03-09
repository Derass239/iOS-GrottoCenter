//
//  FavorisCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 09/03/2021.
//

import UIKit

class FavorisCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = FavorisViewController(nibName: nil, bundle: nil)
    viewController.viewModel = FavorisViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
