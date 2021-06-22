//
//  MBXCluserView.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 02/06/2021.
//

import Foundation
import Mapbox
import ClusterKit

class MBXClusterView: MGLAnnotationView {

  var imageView: UIImageView!

  override init(annotation: MGLAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    let image = UIImage(named: "loc")
    imageView = UIImageView(image: image)
    addSubview(imageView)
    frame = imageView.frame

    centerOffset = CGVector(dx: 0.5, dy: 1)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Not implemented")
  }

}
