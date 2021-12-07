//
//  SearchScreenCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class SearchCoordinator: Coordinator {
  
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = SearchViewController()
    viewController.viewModel = SearchViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }

  func showCaveDetail(caveId: Int) {
    let coordinator = CaveDetailCoordinator(navigationController: navigationController, caveId: caveId)
    coordinate(to: coordinator)
  }
}
