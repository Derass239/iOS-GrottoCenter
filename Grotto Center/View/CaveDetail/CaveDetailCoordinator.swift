//
//  CaveDetailCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 09/06/2021.
//

import UIKit

class CaveDetailCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController

  let caveId: Int

  init(navigationController: UINavigationController, caveId: Int) {
    self.navigationController = navigationController
    self.caveId = caveId
  }
  
  func start() {
    let viewController = CaveDetailViewController(nibName: nil, bundle: nil)
    viewController.viewModel = CaveDetailViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
}
