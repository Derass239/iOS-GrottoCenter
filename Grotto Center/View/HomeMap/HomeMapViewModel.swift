//
//  HomeMapScreenViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeMapViewModel {
  
  let coordinator: HomeMapCoordinator

  var disposeBag = DisposeBag()

  var mapPoi = BehaviorRelay<[MapPoi]>(value: [])
  let mapUrl = URL(string: "mapbox://styles/derass/ckomz31ky0v8t17pdzxgoe7cq")

  init(coordinator: HomeMapCoordinator) {
    self.coordinator = coordinator

  }

  func getGeolocEntrance(edges: Edges) {
    Service.shared.getGeoloEntrances(edges: edges)
      .subscribe(onNext: { [weak self] entrances in
        self?.mapPoi.accept(entrances)
      })
      .disposed(by: disposeBag)
  }

}
