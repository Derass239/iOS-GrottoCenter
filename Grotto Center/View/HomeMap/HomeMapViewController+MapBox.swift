//
//  HomeMapViewController+MapBox.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 02/06/2021.
//

import Foundation
import Mapbox
import ClusterKit

public let CKMapViewAnnotationViewReuseIdentifier = "annotation"
public let CKMapViewClusterAnnotationViewReuseIdentifier = "cluster"

extension HomeMapViewController: MGLMapViewDelegate {

  func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
    guard reason != .programmatic else { return }

    viewModel.getGeolocEntrance(edges: Edges(mapView.visibleCoordinateBounds.ne, mapView.visibleCoordinateBounds.sw))
    mapView.clusterManager.updateClustersIfNeeded()
  }

  func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
    mapView.clusterManager.updateClustersIfNeeded()
  }

  func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {

    let mapPoi = mapView.clusterManager.selectedAnnotation as? MapPoi

    mapView.deselectAnnotation(annotation, animated: false)

    viewModel.coordinator.showCaveDetail(caveId: mapPoi?.id ?? 0)
//    let alert = UIAlertController(title: "test", message: "\(mapPoi!.coordinate)", preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//    self.present(alert, animated: true, completion: nil)
  }

  func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    guard let cluser = annotation as? CKCluster else {
      return true
    }

    return cluser.count == 1
  }


  func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
    mapView.deselectAnnotation(annotation, animated: true)
  }

  func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
    if annotation is MGLUserLocation && mapView.userLocation != nil {
      return nil
    }
    return UIButton(type: .detailDisclosure)
  }

  // Define if POI or Cluster
  func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
    guard let cluster = annotation as? CKCluster else {
      return nil
    }

    if cluster.count > 1 {
      let clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: CKMapViewAnnotationViewReuseIdentifier)
      ?? MBXClusterView(annotation: annotation, reuseIdentifier: CKMapViewClusterAnnotationViewReuseIdentifier)

      return clusterView
    }

    let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CKMapViewAnnotationViewReuseIdentifier)
      ?? MBXAnnotationView(annotation: annotation, reuseIdentifier: CKMapViewAnnotationViewReuseIdentifier)

    return annotationView
  }


  func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
    guard let cluster = annotation as? CKCluster else {
      return
    }

    if cluster.count > 1 {
      let edgePadding = UIEdgeInsets.init(top: 40, left: 20, bottom: 44, right: 20)
      let camera = mapView.cameraThatFitsCluster(cluster, edgePadding: edgePadding)
      mapView.setCamera(camera, animated: true)
    } else if let annotation = cluster.firstAnnotation {
      mapView.clusterManager.selectAnnotation(annotation, animated: false)
    }
  }

  func mapView(_ mapView: MGLMapView, didDeselect annotation: MGLAnnotation) {
    guard let cluster = annotation as? CKCluster, cluster.count == 1 else {
      return
    }

    mapView.clusterManager.deselectAnnotation(cluster.firstAnnotation, animated: false);
  }
}
