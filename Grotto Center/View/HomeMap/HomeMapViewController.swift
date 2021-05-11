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

class HomeMapViewController: ViewController {

  var mapView: MKMapView = { MKMapView().withConstraint() }()

  var viewModel: HomeMapViewModel!
  let disposeBag = DisposeBag()

  let segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl()
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureSegmentControl()
    mapView.register(PoiAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)


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
        for point in poi {
          let annotation = MKPointAnnotation()
          annotation.title = point.name
          annotation.coordinate = point.coordinate
          self?.mapView.addAnnotation(annotation)
        }
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

}
