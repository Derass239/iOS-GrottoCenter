//
//  SearchScreenViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class SearchViewController: GrottoTableViewController {
  
  var viewModel: SearchViewModel!
  override var baseTableViewModel: BaseTableViewModel { return viewModel }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupFullScreenTableView()

  }
}
