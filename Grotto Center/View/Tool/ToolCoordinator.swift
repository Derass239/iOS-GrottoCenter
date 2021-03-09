//
//  ToolCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 02/03/2021.
//

import UIKit

class ToolCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = ToolViewController(nibName: nil, bundle: nil)
    viewController.viewModel = ToolViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
