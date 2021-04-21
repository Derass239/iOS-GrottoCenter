//
//  CardViewStyle.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

public class CardViewStyle {
  // MARK: - Properties
  /// Background of the CardView
  public var background = UIColor.white

  /// Margin of the CardView (Also applied to cell views)
  public var margin: UIEdgeInsets = UIEdgeInsets(top: 4, left: 20, bottom: 6, right: 20)

  /// Corner radius for each corner of the CardView
  public var corners: (UIRectCorner, CGFloat) = ([.topLeft, .topRight, .bottomLeft, .bottomRight], 4)

  /// Shadow side
  public var shadows: Bool = true

  /// Animate when the user clicks
  public var animateShadow: Bool = true

  /// Border width
  public var borderWidth: CGFloat = 0

  /// Border color
  public var borderColor: UIColor = .clear

  // MARK: - Lifecycle
  public init() {}

  public func configureLikeTopCardView() {
    margin.bottom = 0
    corners = ([.topLeft, .topRight], 4)
  }

  public func configureLikeCenterCardView() {
    margin.bottom = 0
    margin.top = 0
    corners = ([], 0)
  }

  public func configureLikeBottomCardView() {
    margin.top = 0
    margin.bottom = 6
    corners = ([.bottomLeft, .bottomRight], 4)
  }
}
