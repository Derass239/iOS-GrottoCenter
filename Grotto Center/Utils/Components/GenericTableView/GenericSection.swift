//
//  GenericSection.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

public class GenericSection {
  public var identifier: String = ""
  public var items: [GenericCellData] = []
  public var footerSpace: CGFloat = 0

  public init(identifier: String = "", _ items: [GenericCellData], footerSpace: CGFloat = 0) {
    self.identifier = identifier
    self.items = items
    self.footerSpace = footerSpace
  }

  public func insert(_ item: GenericCellData, at index: Int) {
    items.insert(item, at: index)
  }

  public func remove(at index: Int?) {
    guard let index = index else { return }
    items.remove(at: index)
  }
}
