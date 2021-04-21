//
//  BaseTableViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit
import RxSwift

open class BaseTableViewController: ViewController {
  /// DisposeBag (RxSwift)
  public let disposeBag = DisposeBag()

  /// TableView
  open var tableView: GenericTableView = { return GenericTableView().withConstraint() }()

  /// Bottom constraint to chnage when the keyboard is displayed
  var tableViewBottom: NSLayoutConstraint?

  /// ViewModel
  open var baseTableViewModel: BaseTableViewModel { return BaseTableViewModel() }

  open override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.adapter = TableViewAdapter(self, sections: baseTableViewModel.sections)
  }

  public func setupFullScreenTableView() {
    self.view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    baseTableViewModel.refresh()
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow),
                                           name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide),
                                           name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc func keyboardDidShow(notification: NSNotification) {
    guard let userInfo = notification.userInfo,
          let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
          let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
          let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
    self.view.setNeedsLayout()
    tableViewBottom?.constant = -value.cgRectValue.height
    UIView.animate(withDuration: TimeInterval(duration), delay: 0,
                   options: [UIView.AnimationOptions(rawValue: curve)], animations: {
                    self.view.layoutIfNeeded()
                   })
  }

  @objc func keyboardDidHide(notification: NSNotification) {
    guard let userInfo = notification.userInfo,
          let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
          let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
    self.view.setNeedsLayout()
    tableViewBottom?.constant = 0
    UIView.animate(withDuration: TimeInterval(duration), delay: 0,
                   options: [UIView.AnimationOptions(rawValue: curve)], animations: {
                    self.view.layoutIfNeeded()
                   })
  }

  open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if let item = sender as? GenericCellData {
      item.prepare?(item, segue)
    }
  }

  open func didScroll(tableView: UITableView) {}
}
