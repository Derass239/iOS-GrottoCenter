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
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.adapter = TableViewAdapter(self, sections: baseTableViewModel.sections)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    baseTableViewModel.refresh()
  }

  func setupFullScreenTableView() {
    self.view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self,
                                              name: UIResponder.keyboardWillShowNotification,
                                              object: nil)
    NotificationCenter.default.removeObserver(self,
                                              name: UIResponder.keyboardWillShowNotification,
                                              object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    let userInfo = notification.userInfo!
    var keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
    keyboardFrame = self.view.convert(keyboardFrame, from: nil)

    var contentInset: UIEdgeInsets = self.tableView.contentInset
    contentInset.bottom = keyboardFrame.size.height
    tableView.contentInset = contentInset
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    let contentInset: UIEdgeInsets = UIEdgeInsets.zero
    tableView.contentInset = contentInset
  }

  public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if let item = sender as? GenericCellData {
      item.prepare?(item, segue)
    }
  }
}
