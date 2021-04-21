//
//  GenericViewCell.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 20/04/2021.
//

import UIKit
import RxSwift

open class GenericViewCell: UITableViewCell {

  var containerView: CardView?
  public var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

  private var leadingCardView: NSLayoutConstraint?
  private var trailingCardView: NSLayoutConstraint?
  private var topCardView: NSLayoutConstraint?
  private var bottomCardView: NSLayoutConstraint?

  public var item: GenericCellData?

  public var tableView: UITableView? {
    var superview = self.superview
    while !(superview is UITableView) && superview != nil {
      let newSuperview = superview?.superview //Fix XCode 12 compiler crash
      superview = newSuperview
    }
    return superview as? UITableView
  }

  override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialize()
  }
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }

  open func initialize() {
  }

  open func setCardView(padding: UIEdgeInsets) {
    if containerView == nil {
      containerView = CardView().withConstraint()
      self.contentView.clipsToBounds = true
      guard let containerView = containerView else { return }
      guard let item = item, let cardView = item.cardViewStyle else { return }
      containerView.style = cardView
      contentView.insertSubview(containerView, at: 0)

      topCardView = containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding.top)
      leadingCardView = containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                               constant: padding.left)
      trailingCardView = containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                                 constant: -padding.right)
      bottomCardView = containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                             constant: -padding.bottom)
    } else {
      guard let item = item, let cardView = item.cardViewStyle else { return }
      containerView?.style = cardView
    }


    var diffPadding = padding
    diffPadding.left -= self.padding.left
    diffPadding.right -= self.padding.right
    diffPadding.bottom -= self.padding.bottom
    diffPadding.top -= self.padding.top

    setCardViewConstraint(padding: diffPadding)
    leadingCardView?.isActive = true
    leadingCardView?.constant = padding.left

    trailingCardView?.isActive = true
    trailingCardView?.constant = -padding.right

    topCardView?.isActive = true
    topCardView?.constant = padding.top

    bottomCardView?.isActive = true
    bottomCardView?.constant = -padding.bottom

    //    containerView.layer.shadowColor = UIColor.shadow.cgColor
    //    containerView.layer.shadowOpacity = disabledCard ? 0 : 0.25
    //    containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.padding = padding
  }

  /// Vérifie la contrainte
  /// - Returns: Boolean si la contrainte passée est une constrainte entre la vue parent et ces safearea
  func isLinkSafeArea(constraint: NSLayoutConstraint) -> Bool {
    return (constraint.firstItem is UILayoutSupport && constraint.secondItem as? UIView == self.contentView)
      || (constraint.firstItem as? UIView == self.contentView && constraint.secondItem is UILayoutSupport)
      || (constraint.firstItem is UILayoutGuide && constraint.secondItem as? UIView == self.contentView)
      || (constraint.firstItem as? UIView == self.contentView && constraint.secondItem is UILayoutGuide)
  }

  func setCardViewConstraint(padding: UIEdgeInsets) {
    for constraint in self.contentView.constraints {
      if !isLinkSafeArea(constraint: constraint) {
        if constraint.firstItem as? UIView == contentView || constraint.secondItem as? UIView == contentView
            || constraint.firstItem as? UIView == self || constraint.secondItem as? UIView == self
            || constraint.firstItem is UILayoutGuide || constraint.secondItem is UILayoutGuide {
          if constraint.firstAttribute == .leading || constraint.firstAttribute == .leadingMargin {
            let multiplier: CGFloat = (constraint.firstItem as? UIView == contentView) ? -1 : 1
            constraint.constant += multiplier * padding.left
          } else if constraint.firstAttribute == .trailing || constraint.firstAttribute == .trailingMargin {
            let multiplier: CGFloat = (constraint.firstItem as? UIView == contentView) ? 1 : -1
            constraint.constant += multiplier * padding.right
          } else if constraint.firstAttribute == .top || constraint.firstAttribute == .topMargin {
            let multiplier: CGFloat = (constraint.firstItem as? UIView == contentView) ? -1 : 1
            constraint.constant += multiplier * padding.top
          } else if constraint.firstAttribute == .bottom || constraint.firstAttribute == .bottomMargin {
            let multiplier: CGFloat = (constraint.firstItem as? UIView == contentView) ? 1 : -1
            constraint.constant += multiplier * padding.bottom
          } else if constraint.firstAttribute == .centerY {
            let multiplier: CGFloat = (constraint.firstItem as? UIView == contentView) ? -1 : 1
            constraint.constant += multiplier * (padding.top - padding.bottom)/2
          }
        }
      }
    }
  }

  open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    guard item?.cardViewStyle?.animateShadow ?? false else { return }
    containerView?.withShadow = !highlighted
  }
  open override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    guard item?.cardViewStyle?.animateShadow ?? false else { return }
    containerView?.withShadow = !selected
  }

  open func configure(item: GenericCellData) {
    self.item = item
    item.cell = self
    backgroundColor = item.cellBackground
    selectionStyle = item.selection ? .default : .none

    switch item.separator {
    case .full:
      separatorInset = UIEdgeInsets.zero
    case .none:
      separatorInset = UIEdgeInsets(top: 0, left: bounds.size.width * 10, bottom: 0, right: 0)
    case .custom(let left, let right):
      separatorInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
    if let cardView = item.cardViewStyle {
      setCardView(padding: cardView.margin)
    } else {
      var padding = self.padding
      containerView?.removeFromSuperview()
      containerView = nil
      padding.left = -padding.left
      padding.right = -padding.right
      padding.top = -padding.top
      padding.bottom = -padding.bottom
      setCardViewConstraint(padding: padding)
      self.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  }

  open func refresh() {}

  public func refreshHeight() {
    tableView?.beginUpdates()
    tableView?.endUpdates()
  }

  public var disposeBag = DisposeBag()
  open override func prepareForReuse() {
    disposeBag = DisposeBag()
  }
}
