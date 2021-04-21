//
//  BaseTableViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import Foundation
import RxSwift
import RxRelay

open class BaseTableViewModel {
  public var sections = BehaviorRelay<[GenericSection]>(value: [])

  public init() {}
  open func refresh() {}
  public func exist(_ identifier: String) -> Bool { return search(identifier) != nil }

  public func search(_ identifier: String) -> IndexPath? {
    for section in 0..<sections.value.count {
      if let row = sections.value[section].items.firstIndex(where: { $0.identifier == identifier }) {
        return IndexPath(row: row, section: section)
      }
    }
    return nil
  }

  public func search(_ item: GenericCellData) -> IndexPath? {
    for section in 0..<sections.value.count {
      if let row = sections.value[section].items.firstIndex(where: { $0 === item }) {
        return IndexPath(row: row, section: section)
      }
    }
    return nil
  }

  public func data(_ identifier: String) -> GenericCellData? {
    guard let indexPath = search(identifier) else { return nil }
    return sections.value[indexPath.section].items[indexPath.row]
  }

  public func searchSection(_ identifier: String) -> Int? {
    return sections.value.firstIndex(where: { $0.identifier == identifier })
  }

  public func section(_ identifier: String) -> GenericSection? {
    return sections.value.first(where: { $0.identifier == identifier })
  }

  public func remove(_ identifier: String) {
    guard let indexPath = search(identifier) else { return }
    let sections = self.sections.value
    sections[indexPath.section].remove(at: indexPath.row)
    self.sections.accept(sections)
  }

  public func add(data: GenericCellData, after afterIdentifier: String) {
    guard let indexPath = search(afterIdentifier),
          (data.identifier.isEmpty || !exist(data.identifier)) else { return }
    let sections = self.sections.value
    sections[indexPath.section].insert(data, at: indexPath.row + 1)
    self.sections.accept(sections)
  }
}

