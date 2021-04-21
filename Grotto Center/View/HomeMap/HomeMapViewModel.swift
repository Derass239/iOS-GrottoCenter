//
//  HomeMapScreenViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift
import RxRelay

class HomeMapViewModel {
  
  let coordinator: HomeMapCoordinator

  var disposeBag = DisposeBag()
  
  init(coordinator: HomeMapCoordinator) {
    self.coordinator = coordinator

    getEntrance()
  }

  func getEntrance() {
    Service.shared.getEntrance(id: 5550)
      .subscribe(onNext: {[weak self] entrance in
        print(entrance)
      })
      .disposed(by: disposeBag)
  }

  func getCave() {
    Service.shared.getCave(id: 5550)
      .subscribe(onNext: {[weak self] cave in
        print(cave)
      })
      .disposed(by: disposeBag)
  }
}
