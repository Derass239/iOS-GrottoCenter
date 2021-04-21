//
//  HomeMapScreenViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit

class HomeMapViewController: GrottoTableViewController {

  var headerView: UIView = { UIView().withConstraint() }()
  var headerTitle: UILabel = {
    let label = UILabel().withConstraint()
    label.numberOfLines = 0
    return label
  }()

  var viewModel: HomeMapViewModel!


  override func viewDidLoad() {
    super.viewDidLoad()

    headerTitle.text = "HELLO"
    
  }

  override func addSubviews() {
    view.addSubview(headerView)
    headerView.addSubview(headerTitle)
    view.addSubview(tableView)
  }

  override func setupLayout() {
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerTitle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30),
      headerTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -30),
      headerTitle.leadingAnchor.constraint(equalTo: headerView.layoutMarginsGuide.leadingAnchor, constant: 16),
      headerTitle.trailingAnchor.constraint(equalTo: headerView.layoutMarginsGuide.trailingAnchor, constant: -16),
      tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
