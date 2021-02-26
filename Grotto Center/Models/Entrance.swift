//
//  Entrance.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 15/02/2021.
//

import Foundation

class Entrance {
  var entranceId: Int = 0
  var name: String = ""
//  var names: [Name] = [Name]()
  var descriptions: [String] = [String]()
  var city: String = "-"
  var county: String = "-"
  var region: String = "-"
  var country: String = "-"
  var latitude: Double = 0
  var longitude: Double = 0
//  var stats: EntranceStats
  var cave: Cave = Cave()
//  var documents: [Document]
//  var locations
//  var riggings
//  var comments
  
  init() {}
}
