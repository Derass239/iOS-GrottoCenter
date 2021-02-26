//
//  ViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 25/02/2021.
//

import Foundation
import RxSwift

class ViewController: UIViewController {
  
  @IBOutlet weak var safeAreaCompatibilityContainerView: UIView!
  
  override func viewDidLoad() {

    //safeAreaCompatibilityContainerView.backgroundColor = UIColor(white: 250.0 / 255.0, alpha: 1.0)
    
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if #available(iOS 11, *) {
      
    } else {
      safeAreaCompatibilityContainerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    updateViewHeightIfNeeded()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.frame = UIScreen.main.bounds
  }
  
  fileprivate func updateViewHeightIfNeeded() {
    guard let safeNavigationController = navigationController else {
      return
    }
    
    var newHeight = safeNavigationController.view.bounds.height
    
    if let safeTabBarController = tabBarController {
      newHeight -= safeTabBarController.tabBar.bounds.height
    }
    
    guard view.bounds.height != newHeight else { return }
    
    view.frame.size.height = newHeight
    view.layoutIfNeeded()
  }
}
