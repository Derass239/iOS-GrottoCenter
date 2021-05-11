//
//  MapPoi.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 04/05/2021.
//

import Foundation
import MapKit

enum PoiType {
  case cave
  case entrance
  case orga
}

class MapPoi: NSObject, MKAnnotation {

  var id: Int = 0
  var name: String = ""
  var coordinate: CLLocationCoordinate2D
  var region: String = ""
  var city: String = ""

  var poiType: PoiType = .cave

  init(id: Int, name: String, coordinate: CLLocationCoordinate2D, region: String, city: String, type: PoiType) {
    self.id = id
    self.name = name
    self.coordinate = coordinate
    self.region = region
    self.city = city
    self.poiType = type
  }

  init(_ array: [String: Any], type: PoiType) {
    let json = JSON(array)
    id = json["id"].value(0)
    name = json["name"].value("")
    coordinate = CLLocationCoordinate2D(latitude: json["latitude"].value(0), longitude: json["longitude"].value(0))
    region = json["region"].value("")
    city = json["city"].value("")
    poiType = type
  }
}
