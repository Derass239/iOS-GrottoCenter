//
//  LaunchscreenViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 25/02/2021.
//

import UIKit

class LaunchscreenViewController: ViewController {
  
  var viewModel: LaunchscreenViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
      self.viewModel.showMainView()
    })
  }
}
