//
//  HomeMapScreenViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxMKMapView
import MapKit
import Cluster

class HomeMapViewController: ViewController {

  var mapView: MKMapView = { MKMapView().withConstraint() }()

  var viewModel: HomeMapViewModel!
  let disposeBag = DisposeBag()

  let segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl()
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()

  lazy var manager: ClusterManager = { [unowned self] in
    let manager = ClusterManager()
    manager.delegate = self
    manager.maxZoomLevel = 17
    manager.minCountForClustering = 2
    manager.clusterPosition = .nearCenter
    return manager
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureSegmentControl()

//    mapView.register(PoiAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

    mapView.rx
      .setDelegate(self)
      .disposed(by: disposeBag)

    mapView.rx.didFinishLoadingMap
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.getGeolocEntrance(edges: (self?.mapView.edgePoints())!)
      }).disposed(by: disposeBag)

    viewModel.mapPoi
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: {[weak self] poi in
        guard let self = self else { return }
        self.manager.removeAll()
        for point in poi {
          let annotation = Annotation()
          annotation.title = point.name
          annotation.coordinate = point.coordinate
          self.manager.add(annotation)
          //self?.mapView.addAnnotation(annotation)
        }
        self.manager.reload(mapView: self.mapView)
      })
      .disposed(by: disposeBag)
  }

  func configureSegmentControl() {
    segmentedControl.insertSegment(withTitle: "Stantard", at: 0, animated: false)
    segmentedControl.insertSegment(withTitle: "Satellite", at: 1, animated: false)
    segmentedControl.insertSegment(withTitle: "Hybride", at: 2, animated: false)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.rx.selectedSegmentIndex.asObservable()
      .subscribe(onNext: {
        switch $0 {
        case 0 : self.mapView.mapType = .standard
        case 1 : self.mapView.mapType = .satellite
        case 2 : self.mapView.mapType = .hybrid
        default: break
        }
      }).disposed(by: disposeBag)
  }

  override func addSubviews() {
    view.addSubview(mapView)
    view.addSubview(segmentedControl)
  }

  override func setupLayout() {
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: view.topAnchor),
      mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      segmentedControl.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 0),
      segmentedControl.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16)
    ])
  }
}

extension HomeMapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if let annotation = annotation as? ClusterAnnotation {
      let index = segmentedControl.selectedSegmentIndex
      let identifier = "Cluster\(index)"
      let selection = Selection(rawValue: index)!
      return mapView.annotationView(selection: selection, annotation: annotation, reuseIdentifier: identifier)
    } else if let annotation = annotation as? MeAnnotation {
      let identifier = "Me"
      let annotationView = mapView.annotationView(of: MKAnnotationView.self, annotation: annotation, reuseIdentifier: identifier)
      annotationView.image = .me
      return annotationView
    } else {
      let identifier = "Pin"
      let annotationView = mapView.annotationView(of: MKPinAnnotationView.self, annotation: annotation, reuseIdentifier: identifier)
      annotationView.pinTintColor = .green
      return annotationView
    }
  }

  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard let annotation = view.annotation else { return }

    if let cluster = annotation as? ClusterAnnotation {
      var zoomRect = MKMapRect.null
      for annotation in cluster.annotations {
        let annotationPoint = MKMapPoint(annotation.coordinate)
        let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)
        if zoomRect.isNull {
          zoomRect = pointRect
        } else {
          zoomRect = zoomRect.union(pointRect)
        }
      }
      mapView.setVisibleMapRect(zoomRect, animated: true)
    }
  }

  func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
    views.forEach { $0.alpha = 0 }
    UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
      views.forEach { $0.alpha = 1 }
    }, completion: nil)
  }
}

extension HomeMapViewController: ClusterManagerDelegate {

  func cellSize(for zoomLevel: Double) -> Double? {
    return nil // default
  }

  func shouldClusterAnnotation(_ annotation: MKAnnotation) -> Bool {
    return !(annotation is MeAnnotation)
  }

}

extension HomeMapViewController {
  enum Selection: Int {
    case count, imageCount, image
  }
}

extension MKMapView {
  func annotationView(selection: HomeMapViewController.Selection, annotation: MKAnnotation?, reuseIdentifier: String) -> MKAnnotationView {
    switch selection {
    case .count:
      let annotationView = self.annotationView(of: CountClusterAnnotationView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
      annotationView.countLabel.backgroundColor = .green
      return annotationView
    case .imageCount:
      let annotationView = self.annotationView(of: ImageCountClusterAnnotationView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
      annotationView.countLabel.textColor = .green
      annotationView.image = .pin2
      return annotationView
    case .image:
      let annotationView = self.annotationView(of: MKAnnotationView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
      annotationView.image = .pin
      return annotationView
    }
  }
}

class MeAnnotation: Annotation {}
