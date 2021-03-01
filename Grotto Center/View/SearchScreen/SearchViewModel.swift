//
//  SearchScreenViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift
import RxRelay

class SearchViewModel {
  
  let coordinator: SearchCoordinator
  
  init(coordinator: SearchCoordinator) {
    self.coordinator = coordinator
    
  }
}
