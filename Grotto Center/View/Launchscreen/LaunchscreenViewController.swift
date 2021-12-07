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
  }

  override func viewDidAppear(_ animated: Bool) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
      self.viewModel.showMainView()
    })
  }

  override func configure() {
    super.configure()

    view.backgroundColor = UIColor(red: 89, green: 65, blue: 57, alpha: 1)
  }
}
