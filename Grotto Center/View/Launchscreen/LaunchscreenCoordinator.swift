//
//  LaunchscreenCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 25/02/2021.
//

import UIKit


class LaunchscreenCoordinator: Coordinator {
  
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = LaunchscreenViewController(nibName: "Launchscreen", bundle: nil)
    viewController.viewModel = LaunchscreenViewModel(coordinator: self)
    
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func coordinateToTabBar() {
    let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
    coordinate(to: tabBarCoordinator)
  }
}
