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


  var caveUrl: String {
    return address + cave
  }

  var entranceUrl: String {
    return address + entrance
  }

}

extension NormalMode: ServiceProtocol {

  // +---------+---------+---------+---------+---------+---------+---------+---------+
  // |                                                                               |
  // |                       MARK: - G E T
  // |                                                                               |
  // +---------+---------+---------+---------+---------+---------+---------+---------+
  
  func getCave(id: Int) -> Observable<Cave> {
    return Observable.create { [weak self] observable -> Disposable in
      Communicator.shared.get(address: self!.caveUrl + "\(id)")
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
      Communicator.shared.get(address: self!.entranceUrl + "\(id)")
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
}
