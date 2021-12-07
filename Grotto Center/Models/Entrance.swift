//
//  Entrance.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 15/02/2021.
//

import Foundation

class Entrance {
  var id: Int = 0
  var name: String = ""
  var city: String = ""
  var country: String = ""
  var county: String = ""
  var latitude: Double = 0
  var longitude: Double = 0
  var region: String = ""
  var aestheticism: Int = 0
  var caving: Int = 0
  var approach: Int = 0

  var cave: Cave?
  var locations: [Location] = [Location]()

  init() {}

  init(_ array: [String: Any]) {
    let json = JSON(array)
    id = json["id"].value(0)
    name = json["name"].value("")
    city = json["city"].value("")
    country = json["country"].value("")
    county = json["county"].value("")
    region = json["region"].value("")
    latitude = json["latitude"].value(0.0)
    longitude = json["longitude"].value(0.0)
    aestheticism = json["stats"]["aestheticism"].value(0)
    caving = json["stats"]["caving"].value(0)
    approach = json["stats"]["approach"].value(0)

    for location in json["locations"].value([[:]]) {
      guard let location = location as? [String: Any] else { continue }
      locations.append(Location(location))
    }

    guard let jsonCave = json["cave"].value([:]) as? [String: Any] else { return }
    cave = Cave(jsonCave)
  }
}
