//
//  HomeMapScreenViewController.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Mapbox
import ClusterKit

class HomeMapViewController: ViewController {

  var viewModel: HomeMapViewModel!
  let disposeBag = DisposeBag()

  var mapView: MGLMapView = {
    let mapView = MGLMapView().withConstraint()
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return mapView
  }()

  let segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl()
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()

  let algorithm: CKNonHierarchicalDistanceBasedAlgorithm = {
    let algorithm = CKNonHierarchicalDistanceBasedAlgorithm()
    algorithm.cellSize = 100
    return algorithm
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureMapView()
    configureSegmentControl()

    viewModel.mapPoi
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: {[weak self] poi in
        guard let self = self else { return }
        var pointAnnotations = [MapPoi]()
        for point in poi {
          pointAnnotations.append(point)
        }
        self.mapView.clusterManager.annotations = pointAnnotations
      })
      .disposed(by: disposeBag)
  }

  func configureMapView() {
    mapView.delegate = self
    mapView.clusterManager.algorithm = algorithm
    mapView.clusterManager.marginFactor = 1
    mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    mapView.setCenter(CLLocationCoordinate2D(latitude: 46.123552, longitude: 2.606655), zoomLevel: 5, animated: false)
    mapView.styleURL = viewModel.mapUrl
    mapView.scaleBar.isHidden = false
    mapView.attributionButtonPosition = .bottomLeft
    mapView.attributionButtonMargins.x = mapView.logoView.frame.width + 10
    mapView.compassView.isHidden = false
  }

  func configureSegmentControl() {
    segmentedControl.insertSegment(withTitle: "Stantard", at: 0, animated: false)
    segmentedControl.insertSegment(withTitle: "Satellite", at: 1, animated: false)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.rx.selectedSegmentIndex.asObservable()
      .subscribe(onNext: {
        switch $0 {
        case 0 : self.mapView.styleURL = self.viewModel.mapUrl
        case 1 : self.mapView.styleURL = MGLStyle.satelliteStyleURL
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
      mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      segmentedControl.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -2),
      segmentedControl.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -8)
    ])
  }
  
}
