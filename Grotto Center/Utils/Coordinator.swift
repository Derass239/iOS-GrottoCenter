//
//  Coordinator.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 25/02/2021.
//

import Foundation

protocol Coordinator {
  func start()
  func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
  func coordinate(to coordinator: Coordinator) {
    coordinator.start()
  }
}
