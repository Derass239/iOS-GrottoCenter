//
//  Location.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 19/04/2021.
//

import Foundation

class Location {
  var id: Int = 0
  var entrance: Int = 0
  var body: String = "-"

  init() {}

  init(_ array: [String: Any]) {
    let json = JSON(array)
    id = json["id"].value(0)
    entrance = json["entrance"].value(0)
    body = json["body"].value("-")
  }
}
