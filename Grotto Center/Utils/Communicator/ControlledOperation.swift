//
//  ControlledOperation.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 13/04/2021.
//

import Foundation

/// Hérite de Operation. Permet de changer les états de l’opération
/// et ainsi définir quand l’opération est vraiment terminée.
class ControlledOperation: Operation {
  /**
   État de l'opération
   - .ready
   - .executing
   - .finished
   */
  enum State: String {
    case ready
    case executing
    case finished
  }

  /**
   État de l'opération. A Chaque qu'on change sa valeur, on met à jour isExecuting et isFinished
   */
  var state: State = .ready {
    willSet {
      willChangeValue(forKey: "isExecuting")
      willChangeValue(forKey: "isFinished")
    }
    didSet {
      didChangeValue(forKey: "isExecuting")
      didChangeValue(forKey: "isFinished")
    }
  }

  override var isExecuting: Bool {
    return state == .executing
  }
  override var isFinished: Bool {
    return state == .finished
  }
  override var isAsynchronous: Bool {
    return true
  }

  override func start() {
    // Si l'opération est stoppé
    if self.isCancelled {
      // On change direct l'état de celle-ci en finished
      state = .finished
    } else {
      // On lance l'opération
      state = .ready
      main()
    }
  }

  override func main() {
    // Si l'opération est stoppé
    if self.isCancelled {
      // On change direct l'état de celle-ci en finished
      state = .finished
    } else {
      // On lance l'opération
      state = .executing
    }
  }
}
