//
//  TabBarViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 01/03/2021.
//

import UIKit
import RxSwift
import RxRelay

class TabBarViewModel {
  
  let coordinator: TabBarCoordinator
  
  init(coordinator: TabBarCoordinator) {
    self.coordinator = coordinator
    
  }
}
