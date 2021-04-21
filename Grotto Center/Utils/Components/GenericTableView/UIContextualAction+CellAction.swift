//
//  UIContextualAction+CellAction.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

extension UIContextualAction {
  static func action(with action: CellAction, data: GenericCellData,
                     viewController: UIViewController? = nil) -> UIContextualAction {
    let contextualAction = UIContextualAction(style: .normal, title: action.title) { _, _, completion in
      action.action?(data, viewController)
      completion(true)
    }
    contextualAction.backgroundColor = action.background
    if let image = action.image {
      contextualAction.image = UIImage(named: image)
    }
    return contextualAction
  }
}
