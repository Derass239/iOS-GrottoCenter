//
//  Cave.swift
//  Grotto Center
//
//  Created by Valentin Limagne on 15/02/2021.
//

import Foundation

class Cave {
  var id: Int = 0
  var locked: Bool = false
  var idReviewer: Int = 0
  var idLocker: Int = 0
  var name: String = "-"
  var minDepth: Int = 0
  var maxDepth: Int = 0
  var depth: Int = 0
  var lenght: Int = 0
  var isDiving: Bool = false
  var temperature: Int = 0
  var dateInscription: String = "-"
  var dateReviewed: String = "-"
  var dateLocked: String = "-"
  var author: Int = 0
}
