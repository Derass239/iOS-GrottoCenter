//
//  UIView+Constraint.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

public extension UIView {
  func constraint(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
    return superview?.constraints.first { constraint -> Bool in
      return (constraint.firstItem as? UIView == self && constraint.firstAttribute == attribute)
        || (constraint.secondItem as? UIView == self && constraint.secondAttribute == attribute)
    }
  }

  func withConstraint() -> Self {
    self.translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}
