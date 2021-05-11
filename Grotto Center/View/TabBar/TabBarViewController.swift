//
//  TabBarViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 01/03/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  var viewModel: TabBarViewModel!
  
  fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tabBar.layer.masksToBounds = true
    self.tabBar.barStyle = .black
    self.tabBar.barTintColor = .white
    self.tabBar.tintColor = UIColor.orange
    
    self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
    self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
    self.tabBar.layer.shadowRadius = 10
    self.tabBar.layer.shadowOpacity = 1
    self.tabBar.layer.masksToBounds = false

  }

  var freshLaunch = true
  override func viewWillAppear(_ animated: Bool) {
    if freshLaunch == true {
      freshLaunch = false
      self.selectedIndex = 2
    }
  }

}
