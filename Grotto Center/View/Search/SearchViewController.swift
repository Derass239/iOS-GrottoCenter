//
//  SearchScreenViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift

class SearchViewController: GrottoTableViewController, UISearchBarDelegate {
  
  var viewModel: SearchViewModel!
  override var baseTableViewModel: BaseTableViewModel { return viewModel }

  var searchview: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = .default
    searchBar.placeholder = "Search for a cave"
    searchBar.sizeToFit()
    searchBar.isTranslucent = false
    searchBar.backgroundImage = UIImage()
    return searchBar
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    searchBar.delegate = self

    searchBar.rx.text
      .orEmpty
      .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .filter { !$0.isEmpty }
      .subscribe(onNext: { [weak self] query in
        self?.viewModel.postSearch(query: query)
      })
      .disposed(by: viewModel.disposeBag)

    tableView.separatorStyle = .singleLine

    let gesture = UITapGestureRecognizer(target: self, action: #selector(removeKeyboard))
    gesture.cancelsTouchesInView = false
    self.view.addGestureRecognizer(gesture)
  }

  @objc func removeKeyboard() {
    self.view.endEditing(true)
  }

  override func addSubviews() {
    super.addSubviews()
    view.addSubview(searchview)
    searchview.addSubview(searchBar)
    view.addSubview(tableView)
  }

  override func setupLayout() {
    super.setupLayout()
    NSLayoutConstraint.activate([
      searchview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
      searchview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchview.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      searchBar.topAnchor.constraint(equalTo: searchview.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: searchview.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: searchview.trailingAnchor),
      searchBar.bottomAnchor.constraint(equalTo: searchview.bottomAnchor),

      tableView.topAnchor.constraint(equalTo: searchview.bottomAnchor, constant: 8),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }

}
