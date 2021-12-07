//
//  CaveDetailViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 09/06/2021.
//

import UIKit
import RxSwift
import RxRelay

class CaveDetailViewModel: BaseTableViewModel {
  let disposeBag = DisposeBag()
  let coordinator: CaveDetailCoordinator
  let caveId: Int
  var cave: Entrance? = nil
  
  init(coordinator: CaveDetailCoordinator, caveId: Int) {
    self.coordinator = coordinator
    self.caveId = caveId
  }

  func getCaveDetail() {
    Service.shared.getEntrance(id: caveId)
      .subscribe(onNext: {[weak self] cave in
        guard let self = self else { return }
        self.cave = cave
        self.refresh()
      })
      .disposed(by: disposeBag)
  }

  override func refresh() {
    super.refresh()

    var datas = [GenericCellData]()

    let titleData = SearchResultData(title: cave?.name ?? "")
    datas.append(titleData)


    sections.accept([GenericSection(datas)])
  }

}
