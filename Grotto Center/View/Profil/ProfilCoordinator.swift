//
//  ProfilCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 02/03/2021.
//

import UIKit

class ProfilCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = ProfilViewController(nibName: nil, bundle: nil)
    viewController.viewModel = ProfilViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
