//
//  LaunchscreenViewModel.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 25/02/2021.
//

import UIKit
import RxSwift
import RxRelay

class LaunchscreenViewModel {
  
  let coordinator: LaunchscreenCoordinator
  
  init(coordinator: LaunchscreenCoordinator) {
    self.coordinator = coordinator
    
  }
  
  func showMainView() {
    coordinator.coordinateToTabBar()
  }
}
