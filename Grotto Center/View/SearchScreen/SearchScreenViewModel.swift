//
//  SearchScreenViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 26/02/2021.
//

import UIKit
import RxSwift
import RxRelay

class SearchScreenViewModel {
  
  let coordinator: SearchScreenCoordinator
  
  init(coordinator: SearchScreenCoordinator) {
    self.coordinator = coordinator
    
  }
}
