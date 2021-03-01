//
//  TabBarCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 01/03/2021.
//

import UIKit

class TabBarCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = TabBarViewController()
    viewController.viewModel = TabBarViewModel(coordinator: self)
    
    let homeMapController = HomeMapViewController()
    homeMapController.tabBarItem = UITabBarItem(title: "Accueil", image: UIImage(named: "home"), tag: 0)
    let homeMapCoordinator = HomeMapCoordinator(navigationController: navigationController)
    
    let searchController = SearchViewController()
    searchController.tabBarItem = UITabBarItem(title: "search", image: UIImage(named: "search"), tag: 1)
    let searchCoordinator = SearchCoordinator(navigationController: navigationController)
    
    let settingController = SettingViewController()
    settingController.tabBarItem = UITabBarItem(title: "Accueil", image: UIImage(named: "wrench"), tag: 2)
    let settingCoordinator = SettingCoordinator(navigationController: navigationController)
    
    viewController.viewControllers = [homeMapController, searchController, settingController]
    
    viewController.modalPresentationStyle = .fullScreen
    
    navigationController.present(viewController, animated: true)
    
    coordinate(to: homeMapCoordinator)
    coordinate(to: searchCoordinator)
    coordinate(to: settingCoordinator)
  }
}
