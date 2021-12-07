//
//  SearchResultCell.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 08/07/2021.
//

import UIKit

class SearchResultCell: GenericViewCell {

  var titleLabel: UILabel = { return UILabel().withConstraint() }()
  var detailsLabel: UILabel = { return UILabel().withConstraint() }()
  var infosView: UIView = { return UIView().withConstraint() }()

  public var leadingConstraint: NSLayoutConstraint?
  public var trailingConstraint: NSLayoutConstraint?
  public var topConstraint: NSLayoutConstraint?
  public var bottomConstraint: NSLayoutConstraint?

  var insets = UIEdgeInsets.zero

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubviews()
    setup()
  }

  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

  func addSubviews() {
    contentView.addSubview(infosView)
    infosView.addSubview(titleLabel)
    infosView.addSubview(detailsLabel)
  }

  func setup() {
    NSLayoutConstraint.activate([
      infosView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: infosView.leadingAnchor, constant: 8),
      titleLabel.topAnchor.constraint(equalTo: infosView.topAnchor),
      titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: infosView.trailingAnchor, constant: -8),
      detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      detailsLabel.leadingAnchor.constraint(equalTo: infosView.leadingAnchor, constant: 8),
      detailsLabel.trailingAnchor.constraint(lessThanOrEqualTo: infosView.trailingAnchor, constant: -8),
      detailsLabel.bottomAnchor.constraint(equalTo: infosView.bottomAnchor)
    ])

    leadingConstraint = infosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    trailingConstraint = infosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    topConstraint = infosView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor)
    bottomConstraint = infosView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)

    leadingConstraint?.isActive = true
    trailingConstraint?.isActive = true
    topConstraint?.isActive = true
    bottomConstraint?.isActive = true
  }

  public override func configure(item: GenericCellData) {
    super.configure(item: item)
    guard let data = item as? SearchResultData else { return }

    titleLabel.attributedText = data.title.attributedString
    titleLabel.numberOfLines = data.title.numberOfLines
    detailsLabel.attributedText = data.details.attributedString
    detailsLabel.numberOfLines = data.details.numberOfLines

    var diffInsets = data.insets
    diffInsets.left -= self.insets.left
    diffInsets.right -= self.insets.right
    diffInsets.bottom -= self.insets.bottom
    diffInsets.top -= self.insets.top
    insets = data.insets

    leadingConstraint?.constant += diffInsets.left
    trailingConstraint?.constant += -diffInsets.right
    topConstraint?.constant += diffInsets.top
    bottomConstraint?.constant += -diffInsets.bottom
  }
}
