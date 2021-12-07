//
//  StringInformation.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 09/07/2021.
//

import UIKit

public class StringInformation {
  public var string: String = "" {
    didSet {
      resetAttributes()
    }
  }
  public var numberOfLines = 0
  public var alignment: NSTextAlignment = .natural
  public var attributes: [NSRange?: [NSAttributedString.Key: Any]] = [:]

  public var attributedString: NSAttributedString {
    let string = NSMutableAttributedString(string: self.string)
    attributes.sorted { $0.key?.length ?? Int.max > $1.key?.length ?? Int.max }
      .forEach { string.addAttributes($1, range: $0 ?? NSRange(0..<self.string.count)) }
    return string
  }

  public init() {}
  public init(string: String,
              color: UIColor = UIColor.black,
              font: UIFont = UIFont.systemFont(ofSize: 16)) {
    self.string = string
    addAttributes(attributes: [.foregroundColor: color,
                               .font: font])
  }

  public func addAttributes(range: NSRange? = nil, attributes: [NSAttributedString.Key: Any]) {
    var rangeAttributes = self.attributes[range] ?? [:]
    attributes.forEach { rangeAttributes[$0] = $1 }
    self.attributes[range] = rangeAttributes
  }

  public func addAttributes(attributes: [NSRange?: [NSAttributedString.Key: Any]]) {
    attributes.forEach { addAttributes(range: $0, attributes: $1) }
  }

  public func resetAttributes() {
    for (key, _) in attributes where key != nil {
      attributes.removeValue(forKey: key)
    }
  }

  public func set(attributedString: NSAttributedString) {
    string = attributedString.string
    let length = attributedString.string.count
    attributedString.enumerateAttributes(in: NSRange(location: 0, length: length)) { (attributes, range, stop) in
      self.attributes[range] = attributes
    }
  }
}
