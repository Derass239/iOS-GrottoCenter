//
//  TabBarCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 01/03/2021.
//

import UIKit


// Outil
// Recherche
// Map
// favoris
// param

class TabBarCoordinator: Coordinator {
  
  unowned var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = TabBarViewController()
    viewController.viewModel = TabBarViewModel(coordinator: self)

    let toolController = ToolViewController()
    toolController.tabBarItem = UITabBarItem(title: "Outil", image: UIImage(named: "wrench"), tag: 0)
    let toolCoordinator = ToolCoordinator(navigationController: navigationController)
    toolController.viewModel = ToolViewModel(coordinator: toolCoordinator)

    let searchController = SearchViewController()
    searchController.tabBarItem = UITabBarItem(title: "Recherche", image: UIImage(named: "search"), tag: 1)
    let searchCoordinator = SearchCoordinator(navigationController: navigationController)
    searchController.viewModel = SearchViewModel(coordinator: searchCoordinator)

    let homeMapController = HomeMapViewController()
    homeMapController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "loc"), tag: 2)
    let homeMapCoordinator = HomeMapCoordinator(navigationController: navigationController)
    homeMapController.viewModel = HomeMapViewModel(coordinator: homeMapCoordinator)

    let favorisController = FavorisViewController()
    favorisController.tabBarItem = UITabBarItem(title: "Favoris", image: UIImage(named: "wrench"), tag: 3)
    let favorisCoordinator = FavorisCoordinator(navigationController: navigationController)
    favorisController.viewModel = FavorisViewModel(coordinator: favorisCoordinator)

    let settingController = SettingViewController()
    settingController.tabBarItem = UITabBarItem(title: "Param", image: UIImage(named: "wrench"), tag: 4)
    let settingCoordinator = SettingCoordinator(navigationController: navigationController)
    settingController.viewModel = SettingViewModel(coordinator: settingCoordinator)

    viewController.viewControllers = [toolController, searchController, homeMapController,
                                      favorisController, settingController]
    
    viewController.modalPresentationStyle = .fullScreen
    
    navigationController.present(viewController, animated: true)

    coordinate(to: toolCoordinator)
    coordinate(to: searchCoordinator)
    coordinate(to: homeMapCoordinator)
    coordinate(to: favorisCoordinator)
    coordinate(to: settingCoordinator)
  }
}
