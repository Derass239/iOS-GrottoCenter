//
//  CaveDetailViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 09/06/2021.
//

import UIKit

class CaveDetailViewController: GrottoTableViewController {
  
  var viewModel: CaveDetailViewModel!
  override var baseTableViewModel: BaseTableViewModel { return viewModel }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFullScreenTableView() 
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.getCaveDetail()
  }

  override func viewDidAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
}
