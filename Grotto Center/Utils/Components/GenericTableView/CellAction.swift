//
//  CellAction.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

public class CellAction {
  public var title: String?
  public var image: String?
  public var background: UIColor? = .clear
  public var action: ((GenericCellData, UIViewController?) -> Void)?

  public init(title: String? = nil, image: String? = nil, background: UIColor?,
              action: ((GenericCellData, UIViewController?) -> Void)?) {
    self.title = title
    self.action = action
    self.image = image
    self.background = background
  }
}
