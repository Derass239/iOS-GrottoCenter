//
//  Service.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 13/04/2021.
//

import Foundation
import RxSwift

class Service {

  let disposeBag = DisposeBag()

  static var shared = Service()

  // Demo
  var demoMode: Bool = false

  var service: ServiceProtocol? = NormalMode()

  private init() {}

  func configure(demoMode: Bool) {
    self.demoMode = demoMode
    if demoMode {
      //service = DemoMode()
    } else {
      service = NormalMode()
    }
  }

  func noService() -> Completable {
    return Completable.error(NSError(domain: "No Service", code: -1, userInfo: nil))
  }
  func noService<T>() -> Observable<T> {
    return Observable.error(NSError(domain: "No Service", code: -1, userInfo: nil))
  }

  func getCave(id: Int) -> Observable<Cave> {
    guard let service = service else { return noService() }
    return service.getCave(id: id)
  }

  func getEntrance(id: Int) -> Observable<Entrance> {
    guard let service = service else { return noService() }
    return service.getEntrance(id: id)
  }
}

