//
//  CaveDetailViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 09/06/2021.
//

import UIKit

class CaveDetailViewController: GrottoTableViewController {
  
  var viewModel: CaveDetailViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFullScreenTableView() 
  }

  override func setupLayout() {
    NSLayoutConstraint.activate([

    ])
  }
}
