//
//  SearchScreenViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift
import RxRelay
import CoreLocation

class SearchViewModel: BaseTableViewModel {
  
  let coordinator: SearchCoordinator?

  var disposeBag = DisposeBag()

  var entrances: [Entrance] = []

  init(coordinator: SearchCoordinator) {
    self.coordinator = coordinator
  }

  func postSearch(query: String) {
    Service.shared.postSearchAdvanced(searchTerm: query)
      .subscribe(onNext: {[weak self] entrances in
        self?.entrances = entrances
        self?.refresh()
      }).disposed(by: disposeBag)
  }

  override func refresh() {
    super.refresh()

    var datas = [GenericCellData]()

    LocationService.shared.start()
    let myLocation = LocationService.shared.currentLocation

    if entrances.isEmpty {
      let data = SearchResultData(title: "Vos anciennes recherches")
      datas.append(data)
    } else {
      for entrance in entrances {
        let entranceLocation = CLLocation(latitude: entrance.latitude, longitude: entrance.longitude)
        let distance = myLocation.distance(from: entranceLocation) / 1000

        let data = SearchResultData.navigation(title: entrance.name,
                                               details: String(format: "\(entrance.city) - \(entrance.country) - %.01f Km", distance))
        data.select = { [weak self] _, _ in
          self?.coordinator?.showCaveDetail(caveId: entrance.id)
          print(entrance.id)
        }
        datas.append(data)
      }
      LocationService.shared.stop()
    }

    sections.accept([GenericSection(datas)])
  }

}
