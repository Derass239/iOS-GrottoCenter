//
//  GrottoTableViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit
import RxSwift

class GrottoTableViewController: ViewController {
  /// TableView
  var tableView: GenericTableView = { return GenericTableView().withConstraint() }()

  /// ViewModel
  var baseTableViewModel: BaseTableViewModel { return BaseTableViewModel() }

  public override func viewDidLoad() {
    super.viewDidLoad()
    tableView.adapter = TableViewAdapter(self, sections: baseTableViewModel.sections)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    baseTableViewModel.refresh()
  }

  func setupFullScreenTableView() {
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if let item = sender as? GenericCellData {
      item.prepare?(item, segue)
    }
  }

  // MARK: - Construction of the views
  override func addSubviews() {
    view.addSubview(tableView)
  }

  override func configure() {
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
  }
}
