//
//  PoiAnnotationView.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 08/05/2021.
//

import Foundation
import MapKit
import Cluster

class PoiAnnotationView: MKMarkerAnnotationView {

  override var annotation: MKAnnotation? {
    willSet {

      if let poi = newValue as? MapPoi {
        clusteringIdentifier = "Poi"
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

class CountClusterAnnotationView: ClusterAnnotationView {
  override func configure() {
    super.configure()

    guard let annotation = annotation as? ClusterAnnotation else { return }
    let count = annotation.annotations.count
    let diameter = radius(for: count) * 2
    self.frame.size = CGSize(width: diameter, height: diameter)
    self.layer.cornerRadius = self.frame.width / 2
    self.layer.masksToBounds = true
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 1.5
  }

  func radius(for count: Int) -> CGFloat {
    if count < 5 {
      return 12
    } else if count < 10 {
      return 16
    } else {
      return 20
    }
  }
}

class ImageCountClusterAnnotationView: ClusterAnnotationView {
  lazy var once: Void = { [unowned self] in
    self.countLabel.frame.size.width -= 6
    self.countLabel.frame.origin.x += 3
    self.countLabel.frame.origin.y -= 6
  }()
  override func layoutSubviews() {
    super.layoutSubviews()

    _ = once
  }
}

extension MKMapView {
  func annotationView<T: MKAnnotationView>(of type: T.Type, annotation: MKAnnotation?, reuseIdentifier: String) -> T {
    guard let annotationView = dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? T else {
      return type.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    annotationView.annotation = annotation
    return annotationView
  }
}

extension UIImage {

  func filled(with color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    color.setFill()
    guard let context = UIGraphicsGetCurrentContext() else { return self }
    context.translateBy(x: 0, y: size.height)
    context.scaleBy(x: 1.0, y: -1.0);
    context.setBlendMode(CGBlendMode.normal)
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    guard let mask = self.cgImage else { return self }
    context.clip(to: rect, mask: mask)
    context.fill(rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
  }

  static let pin = UIImage(named: "pin")?.filled(with: .green)
  static let pin2 = UIImage(named: "pin2")?.filled(with: .green)
  static let me = UIImage(named: "me")?.filled(with: .blue)

}

extension UIColor {
  class var green: UIColor { return UIColor(red: 76 / 255, green: 217 / 255, blue: 100 / 255, alpha: 1) }
  class var blue: UIColor { return UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1) }
}
