//
//  ViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 25/02/2021.
//

import Foundation
import RxSwift

open class ViewController: UIViewController {
  
  @IBOutlet weak var safeAreaCompatibilityContainerView: UIView!
  
  open override func viewDidLoad() {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    self.view.backgroundColor = .white
    
    UIApplication.shared.statusBarStyle = .lightContent

    addSubviews()
    configure()
    setupLayout()
  }
  
  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  open override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
  }
  
  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
   // updateViewHeightIfNeeded()
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //self.view.frame = UIScreen.main.bounds
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

  open func addSubviews() {}
  open func configure() {}
  open func setupLayout() {}
}
