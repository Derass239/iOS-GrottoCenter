//
//  Cave.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 15/02/2021.
//

import Foundation

class Cave {
  var id: Int = 0
  var minDepth: Int = 0
  var maxDepth: Int = 0
  var depth: Int = 0
  var lenght: Int = 0
  var isDiving: Bool = false
  var temperature: Int = 0
  var dateInscription: String = "-"
  var dateReviewed: String = "-"
  var latitude: Double = 0
  var longitude: Double = 0
  var author: Int = 0
  var reviwer: Int = 0
  var massif: Int = 0

  init(id: Int) {
    self.id = id
  }

  init(_ array: [String: Any]) {
    let json = JSON(array)
    id = json["id"].value(0)
    minDepth = json["minDepth"].value(0)
    maxDepth = json["maxDepth"].value(0)
    depth = json["depth"].value(0)
    lenght = json["lenght"].value(0)
    isDiving = json["isDiving"].value(false)
    temperature = json["temperature"].value(0)
    dateInscription = json["dateInscription"].value("")
    dateReviewed = json["dateReviwed"].value("")
    latitude = json["latitude"].value(0)
    longitude = json["longitude"].value(0)
    author = json["author"].value(0)
    reviwer = json["reviwer"].value(0)
    massif = json["massif"].value(0)
  }

}
