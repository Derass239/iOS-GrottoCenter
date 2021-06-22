//
//  MapPoi.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 04/05/2021.
//

import Foundation
import MapKit
import Mapbox

enum PoiType {
  case cave
  case entrance
  case orga
}

class MapPoi: MGLPointAnnotation {

  var id: Int = 0
  var name: String = ""
  var poiCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
  var region: String = ""
  var city: String = ""

  var poiType: PoiType = .cave

  init(id: Int, name: String, poiCoordinate: CLLocationCoordinate2D, region: String, city: String, type: PoiType) {
    super.init()
    self.id = id
    self.name = name
    self.poiCoordinate = poiCoordinate
    self.region = region
    self.city = city
    self.poiType = type
    self.title = name
    self.coordinate = poiCoordinate
  }

  init(_ array: [String: Any], type: PoiType) {
    super.init()
    let json = JSON(array)
    id = json["id"].value(0)
    name = json["name"].value("")
    poiCoordinate = CLLocationCoordinate2D(latitude: json["latitude"].value(0), longitude: json["longitude"].value(0))
    region = json["region"].value("")
    city = json["city"].value("")
    poiType = type
    self.title = name
    self.coordinate = poiCoordinate
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
