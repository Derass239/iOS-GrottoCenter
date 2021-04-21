//
//  GenericTableView.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

open class GenericTableView: FadeTableView {
  public var adapter: TableViewAdapter? {
    didSet {
      adapter?.tableView = self
    }
  }
}
