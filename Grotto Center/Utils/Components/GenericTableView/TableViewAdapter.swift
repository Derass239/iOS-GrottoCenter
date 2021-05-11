//
//  TableViewAdapter.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit
import RxSwift
import RxRelay

public protocol TableViewAdapterDelegate: class {
  func didScroll(tableView: UITableView)
}

open class TableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
  let disposeBag = DisposeBag()

  var backgroundColor: UIColor = .clear {
    didSet {
      tableView?.backgroundColor = backgroundColor
    }
  }
  weak var tableView: UITableView? {
    didSet {
      tableView?.backgroundColor = backgroundColor
      reload()
    }
  }
  weak var viewController: UIViewController?

  var sections: [GenericSection] = [] {
    didSet {
      reload()
    }
  }

  public init(_ viewController: UIViewController, sections: BehaviorRelay<[GenericSection]>) {
    super.init()
    self.viewController = viewController
    sections
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] sections in
        self?.sections = sections
      }).disposed(by: disposeBag)
  }

  func reload() {
    registerCells()
    tableView?.delegate = self
    tableView?.dataSource = self
    tableView?.reloadData()
  }

  func registerCells() {
    for section in sections {
      for item in section.items {
        if let type = item.cellType,
           let identifier = item.cellIdentifier {
          tableView?.register(type, forCellReuseIdentifier: identifier)
        } else if let identifier = item.cellIdentifier {
          tableView?.register(UINib(nibName: identifier, bundle: item.bundle), forCellReuseIdentifier: identifier)
        }
      }
    }
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = sections[indexPath.section].items[indexPath.row]
    guard let identifier = item.cellIdentifier else { return UITableViewCell() }
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    guard let genericCell = cell as? GenericViewCell else { return UITableViewCell() }
    genericCell.configure(item: item)
    return cell
  }
  public func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].items.count
  }
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = sections[indexPath.section].items[indexPath.row]
    tableView.deselectRow(at: indexPath, animated: true)
    item.select?(item, viewController)
  }
  public func tableView(_ tableView: UITableView,
                        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let item = sections[indexPath.section].items[indexPath.row]
    guard !item.leadingActions.isEmpty else { return nil }

    var actions = [UIContextualAction]()
    for action in item.leadingActions {
      actions.append(UIContextualAction.action(with: action, data: item, viewController: viewController))
    }
    return UISwipeActionsConfiguration(actions: actions)
  }
  public func tableView(_ tableView: UITableView,
                        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let item = sections[indexPath.section].items[indexPath.row]
    guard !item.trailingActions.isEmpty else { return nil }

    var actions = [UIContextualAction]()
    for action in item.trailingActions {
      actions.append(UIContextualAction.action(with: action, data: item, viewController: viewController))
    }
    return UISwipeActionsConfiguration(actions: actions)
  }
  public func tableView(_ tableView: UITableView,
                        editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .none
  }
  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return sections[section].footerSpace
  }
  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }

  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let tableView = tableView else { return }
    (viewController as? TableViewAdapterDelegate)?.didScroll(tableView: tableView)
  }
}
