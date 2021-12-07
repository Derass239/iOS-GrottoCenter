//
//  TabBarCoordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 01/03/2021.
//

import UIKit

class TabBarCoordinator: Coordinator {
  
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = TabBarViewController()
    viewController.viewModel = TabBarViewModel(coordinator: self)

    let toolController = UINavigationController()
    toolController.tabBarItem = UITabBarItem(title: "Outil", image: UIImage(named: "wrench"), tag: 0)
    let toolCoordinator = ToolCoordinator(navigationController: toolController)
    //toolController.viewModel = ToolViewModel(coordinator: toolCoordinator)

    let searchController = UINavigationController()
    searchController.tabBarItem = UITabBarItem(title: "Recherche", image: UIImage(named: "search"), tag: 1)
    let searchCoordinator = SearchCoordinator(navigationController: searchController)
    //searchController.viewModel = SearchViewModel(coordinator: searchCoordinator)

    let homeMapController = UINavigationController()
    homeMapController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "loc"), tag: 2)
    let homeMapCoordinator = HomeMapCoordinator(navigationController: homeMapController)
    //homeMapController.viewModel = HomeMapViewModel(coordinator: homeMapCoordinator)

    let favorisController = UINavigationController()
    favorisController.tabBarItem = UITabBarItem(title: "Favoris", image: UIImage(named: "wrench"), tag: 3)
    let favorisCoordinator = FavorisCoordinator(navigationController: favorisController)
    //favorisController.viewModel = FavorisViewModel(coordinator: favorisCoordinator)

    let settingController = UINavigationController()
    settingController.tabBarItem = UITabBarItem(title: "Param", image: UIImage(named: "wrench"), tag: 4)
    let settingCoordinator = SettingCoordinator(navigationController: settingController)
    //settingController.viewModel = SettingViewModel(coordinator: settingCoordinator)

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
