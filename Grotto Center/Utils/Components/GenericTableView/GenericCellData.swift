//
//  GenericCellData.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

open class GenericCellData {
  public enum Separator {
    case full
    case none
    case custom(left: CGFloat, right: CGFloat)
  }

  public enum Accessory {
    case disclosureIndicator(UIColor?)
    case none
  }

  public var cardViewStyle: CardViewStyle?

  open var bundle: Bundle? { return nil }
  open weak var cell: GenericViewCell?
  open var cellIdentifier: String? { return nil }
  open var cellType: GenericViewCell.Type? { return nil }

  public var identifier: String = ""
  public var cellBackground: UIColor = .clear
  public var selection: Bool = true
  public var separator: Separator = .full
  public var accessory: Accessory = .none
  public var select: ((GenericCellData, UIViewController?) -> Void)?
  public var prepare: ((GenericCellData, UIStoryboardSegue) -> Void)?

  public var segue: String = "" {
    didSet {
      if segue.isEmpty {
        self.select = nil
      } else {
        self.select = { item, viewController in
          viewController?.performSegue(withIdentifier: self.segue, sender: item)
        }
      }
    }
  }
  public var leadingActions = [CellAction]()
  public var trailingActions = [CellAction]()

  public init() {}
  public init(identifier: String) {
    self.identifier = identifier
  }

  public func refresh() {
    DispatchQueue.main.async { [weak self] in
      self?.cell?.refresh()
    }
  }

  open func computedSize(parentWidth: CGFloat) -> CGSize { .zero }
}

