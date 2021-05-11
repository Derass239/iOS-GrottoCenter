//
//  ServiceProtocol.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 13/04/2021.
//

import Foundation
import RxSwift

protocol ServiceProtocol {

  // MARK: - GETS
  func getGeoloEntrances(edges: Edges) -> Observable<[MapPoi]>
  func getCave(id: Int) -> Observable<Cave>
  func getEntrance(id: Int) -> Observable<Entrance>
  
  // MARK: - PUTS
}
