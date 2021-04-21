//
//  FadeTableView.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit

open class FadeTableView: UITableView, UIScrollViewDelegate {
  public var topFade: Bool = true {
    didSet {
      setNeedsDisplay()
    }
  }
  public var bottomFade: Bool = true {
    didSet {
      setNeedsDisplay()
    }
  }
  var maxFade: CGFloat = 0.25
  var fadeLayer: CAGradientLayer?

  override public init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    initialize()
  }
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }

  func initialize() {
    let maskLayer = CAGradientLayer()
    self.layer.addSublayer(maskLayer)
    fadeLayer = maskLayer
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    fadeLayer?.locations = [NSNumber(value: 0), NSNumber(value: 10 / Double(self.frame.size.height)),
                            NSNumber(value: 1 - 10 / Double(self.frame.size.height)), NSNumber(value: 1)]
    fadeLayer?.bounds = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    fadeLayer?.anchorPoint = .zero
    scrollViewDidScroll(self)
  }

  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    var opacityTop = min(max(scrollView.contentOffset.y * maxFade / 50, 0), maxFade)
    opacityTop = topFade ? opacityTop : 0
    let diff = scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.size.height
    var opacityBottom = min(max(diff * maxFade / 50, 0), maxFade)
    opacityBottom = bottomFade ? opacityBottom : 0
    fadeLayer?.colors = [UIColor.black.withAlphaComponent(opacityTop).cgColor,
                         UIColor.black.withAlphaComponent(0).cgColor,
                         UIColor.black.withAlphaComponent(0).cgColor,
                         UIColor.black.withAlphaComponent(opacityBottom).cgColor]
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    fadeLayer?.position = CGPoint(x: 0, y: scrollView.contentOffset.y)
    CATransaction.commit()
  }
}
