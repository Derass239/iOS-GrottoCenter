//
//  CaveDetailCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 09/06/2021.
//

import UIKit

class CaveDetailCoordinator: Coordinator {
  
  let navigationController: UINavigationController

  let caveId: Int

  init(navigationController: UINavigationController, caveId: Int) {
    self.navigationController = navigationController
    self.caveId = caveId
  }
  
  func start() {
    let viewController = CaveDetailViewController()
    viewController.viewModel = CaveDetailViewModel(coordinator: self, caveId: caveId)
    viewController.modalPresentationStyle = .automatic

    navigationController.present(viewController, animated: true)
  }
}
