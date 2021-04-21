//
//  CardView.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

public class CardView: UIView {
  public var style: CardViewStyle = CardViewStyle() {
    didSet {
      self.refresh()
    }
  }

  public var withShadow: Bool = true {
    didSet {
      self.refresh()
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.refresh()
  }

  public func refresh() {
    applyCardView(style: style, withShadow: withShadow)
  }
}
