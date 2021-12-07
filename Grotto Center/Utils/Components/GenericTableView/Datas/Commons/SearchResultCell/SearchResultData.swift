//
//  SearchResultData.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 08/07/2021.
//

import UIKit

public class SearchResultData: GenericCellData {

  public enum LabelPriority {
    case title
    case detail
    case none
  }

  public override var cellIdentifier: String? { return "SearchResultCell" }
  public override var cellType: GenericViewCell.Type? { return SearchResultCell.self }

  public var title = StringInformation()
  public var details = StringInformation()
  public var insets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
  public var labelPriority: LabelPriority = .none

  public init(identifier: String = "",
              title: String = "",
              detail: String = "",
              select: ((GenericCellData, UIViewController?) -> Void)? = nil,
              prepare: ((GenericCellData, UIStoryboardSegue) -> Void)? = nil) {
    super.init(identifier: identifier)

    self.cellBackground = .clear
    self.title.string = title
    self.details.string = detail
    self.title.addAttributes(attributes: [.font: UIFont.systemFont(ofSize: 15),
                                          .foregroundColor: UIColor.black])
    self.details.addAttributes(attributes: [.font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor.black])
    self.select = select
    self.prepare = prepare
  }

  public static func navigation(identifier: String = "",
                                title: String,
                                details: String = "",
                                select: ((GenericCellData, UIViewController?) -> Void)? = nil,
                                prepare: ((GenericCellData, UIStoryboardSegue) -> Void)? = nil) -> SearchResultData {
    let data = SearchResultData(identifier: identifier, title: title, detail: details, select: select, prepare: prepare)
    data.title.addAttributes(attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold),
                                          .foregroundColor: UIColor.black])
    data.details.addAttributes(attributes: [.font: UIFont.systemFont(ofSize: 12),
                                            .foregroundColor: UIColor.black])
    data.accessory = .disclosureIndicator(UIColor.black)
    data.selection = true
    return data
  }
}

