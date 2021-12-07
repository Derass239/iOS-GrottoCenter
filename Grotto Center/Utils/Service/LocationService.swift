//
//  LocationService.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 09/07/2021.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {

  static let shared = LocationService()
  var locationManager: CLLocationManager
  var currentLocation: CLLocation = CLLocation()
  //var locationInfoCallBack: ((_ info: LocationInformation) ->())!

  override init() {
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    super.init()
    locationManager.delegate = self
  }

  func start() {
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
  }

  func stop() {
    locationManager.stopUpdatingHeading()
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let mostRecentLocation = locations.last else { return }
    currentLocation = mostRecentLocation
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    stop()
  }
}
