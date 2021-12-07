//
//  AppCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 25/02/2021.
//

import UIKit

class AppCoordinator: Coordinator {
  
  var window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let navigationController = UINavigationController()
    //navigationController.setNavigationBarHidden(true, animated: true)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    let startCoordinator = LaunchscreenCoordinator(navigationController: navigationController)
    coordinate(to: startCoordinator)
  }
}
