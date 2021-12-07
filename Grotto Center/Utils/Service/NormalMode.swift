//
//  NormalMode.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 14/04/2021.
//

import Foundation
import RxSwift

class NormalMode: NSObject {
  var address: String {
    "https://beta.grottocenter.org/api/v1/"
  }

  let cave = "caves/"
  let entrance = "entrances/"
  let geoloc = "geoloc/"
  let searchAdvanced = "advanced-search"

  var geolocEntranceUrl: String {
    return address + geoloc
  }

  var caveUrl: String {
    return address + cave
  }

  var entranceUrl: String {
    return address + entrance
  }

  var searchAdvancedUrl: String {
    return address + searchAdvanced
  }

}

extension NormalMode: ServiceProtocol {

  // +---------+---------+---------+---------+---------+---------+---------+---------+
  // |                                                                               |
  // |                       MARK: - G E T
  // |                                                                               |
  // +---------+---------+---------+---------+---------+---------+---------+---------+

  func getGeoloEntrances(edges: Edges) -> Observable<[MapPoi]> {
    let adress = geolocEntranceUrl + "entrances?" + "sw_lat=\(edges.sw.latitude)&sw_lng=\(edges.sw.longitude)" +
            "&ne_lat=\(edges.ne.latitude)&ne_lng=\(edges.ne.longitude)"
    return Observable.create { observable -> Disposable in
      Communicator.shared.get(address: adress)
        .subscribe(onNext: { json in
          let rep = JSON(json)
          var entrances = [MapPoi]()
          for entrance in rep.value([[:]]).prefix(10000) {
            guard let entrance = entrance as? [String: Any] else {continue}
            entrances.append(MapPoi(entrance, type: .entrance))
          }
          observable.onNext(entrances)
        }, onError: { error in
          observable.onError(error)
        })
        .disposed(by: Service.shared.disposeBag)
      return Disposables.create {}
    }
  }

  func getCave(id: Int) -> Observable<Cave> {
    return Observable.create { [weak self] observable -> Disposable in
      guard let self = self else { return Disposables.create {} }
      Communicator.shared.get(address: self.caveUrl + "\(id)")
        .subscribe(onNext: { json in
          let rep = JSON(json)
          observable.onNext(Cave(id: rep["id"].value(0)))
        }, onError: { error in
          observable.onError(error)
        })
        .disposed(by: Service.shared.disposeBag)
      return Disposables.create {}
    }
  }

  func getEntrance(id: Int) -> Observable<Entrance> {
    return Observable.create { [weak self] observable -> Disposable in
      guard let self = self else { return Disposables.create {} }
      Communicator.shared.get(address: self.entranceUrl + "\(id)")
        .subscribe(onNext: { json in
          let rep = JSON(json)
          observable.onNext(Entrance(rep.dictionary!))
        }, onError: { error in
          observable.onError(error)
        })
        .disposed(by: Service.shared.disposeBag)
      return Disposables.create {}
    }
  }


// +---------+---------+---------+---------+---------+---------+---------+---------+
// |                                                                               |
// |                       MARK: - G E T
// |                                                                               |
// +---------+---------+---------+---------+---------+---------+---------+---------+

  func postSearchAdvanced(searchTerm: String) -> Observable<[Entrance]> {
    let address = self.searchAdvancedUrl + "?resourceType=entrances&name=\(searchTerm)&size=100"
    return Observable.create { [weak self] observable -> Disposable in
      Communicator.shared.post(address: address)
        .subscribe(onNext: { json in
          let rep = JSON(json)
          var entrances = [Entrance]()
          let results = rep.dictionary?["results"] as? NSArray
          for entrance in results ?? [] {
            guard let entrance = entrance as? [String: Any] else { continue }
            entrances.append(Entrance(entrance))
          }
          observable.onNext(entrances)
        }, onError: { error in
          observable.onError(error)
        })
        .disposed(by: Service.shared.disposeBag)
      return Disposables.create {}
    }
  }


}
