//
//  SettingScreenCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class SettingScreenCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = SettingScreenViewController(nibName: nil, bundle: nil)
    viewController.viewModel = SettingScreenViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
