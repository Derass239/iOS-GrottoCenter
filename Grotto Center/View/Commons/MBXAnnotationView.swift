//
//  MBXAnnotationView.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 02/06/2021.
//

import Foundation
import ClusterKit
import Mapbox

class MBXAnnotationView: MGLAnnotationView {

  var imageView: UIImageView!

  override init(annotation: MGLAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    let image = UIImage(named: "entry")
    imageView = UIImageView(image: image)
    addSubview(imageView)
    frame = imageView.frame

    isDraggable = false

    centerOffset = CGVector(dx: 0.5, dy: frame.height/2)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Not implemented")
  }

}
