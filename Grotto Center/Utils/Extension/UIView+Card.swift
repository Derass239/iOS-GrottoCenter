//
//  UIView+Card.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

public extension UIView {
  static let cardViewMask = "cardView"
  static let cardViewBorderMask = "cardViewBorder"

  func applyCardView(style: CardViewStyle, withShadow: Bool = true) {
    removeCardViewStyle()
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: style.corners.0,
                            cornerRadii: CGSize(width: style.corners.1, height: style.corners.1))
    let mask = CAShapeLayer()
    let maskBorder = CAShapeLayer()
    mask.name = UIView.cardViewMask
    maskBorder.name = UIView.cardViewBorderMask
    maskBorder.strokeColor = style.borderColor.cgColor
    maskBorder.lineWidth = style.borderWidth
    mask.fillColor = style.background.cgColor
    maskBorder.fillColor = UIColor.clear.cgColor
    mask.path = path.cgPath
    maskBorder.path = path.cgPath
    if style.shadows && withShadow {
      mask.shadowColor = UIColor.black.cgColor
      mask.shadowOffset = CGSize(width: 0, height: 0)
      let shadowPath = UIBezierPath()
      shadowPath.move(to:  CGPoint(x: 0, y: 0))
      shadowPath.addLine(to: CGPoint(x: bounds.width, y: 0))
      shadowPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
      shadowPath.addLine(to: CGPoint(x: 0, y: bounds.height))
      shadowPath.addLine(to: CGPoint(x: 0, y: 0))
      mask.shadowPath = shadowPath.cgPath
      mask.shadowOpacity = 0.25
    }

    layer.addSublayer(mask)
    layer.addSublayer(maskBorder)
  }

  func removeCardViewStyle() {
    layer.sublayers?.filter { $0.name == UIView.cardViewMask || $0.name == UIView.cardViewBorderMask }
      .forEach { $0.removeFromSuperlayer() }
  }
}
