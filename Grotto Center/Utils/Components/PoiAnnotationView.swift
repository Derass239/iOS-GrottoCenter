//
//  PoiAnnotationView.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 08/05/2021.
//

import Foundation
import MapKit

class PoiAnnotationView: MKMarkerAnnotationView {

  override var annotation: MKAnnotation? {
    willSet {

      if let poi = newValue as? MapPoi {
        switch poi.poiType {
        case .cave:
          markerTintColor = UIColor.blue
          glyphText = "C"
        case .entrance:
          markerTintColor = UIColor.red
          glyphText = "E"
        case .orga:
          markerTintColor = UIColor.green
          glyphText = "O"
        }
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      }
    }
  }
}
