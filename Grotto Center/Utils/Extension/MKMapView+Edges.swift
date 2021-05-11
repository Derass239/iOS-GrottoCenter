//
//  MKMapView+Edges.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 03/05/2021.
//

import Foundation
import MapKit

typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D)

extension MKMapView {
  func edgePoints() -> Edges {
    let nePoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y)
    let swPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)

    let neCoord = self.convert(nePoint, toCoordinateFrom: self)
    let swCoord = self.convert(swPoint, toCoordinateFrom: self)

    return (ne: neCoord, sw: swCoord)
  }
}
