//
//  SearchScreenViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift
import RxRelay

class SearchViewModel: BaseTableViewModel {
  
  let coordinator: SearchCoordinator

  var disposeBag = DisposeBag()

  init(coordinator: SearchCoordinator) {
    self.coordinator = coordinator
    
  }

  func getCave() {
    Service.shared.getCave(id: 5550)
      .subscribe(onNext: {[weak self] cave in
        print(cave)
      })
      .disposed(by: disposeBag)
  }
}
