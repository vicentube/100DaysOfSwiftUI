// RollRoundMO.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

extension RollRoundMO : RollRoundProtocol {
  var date: Date {
    get { dateM ?? Date() }
    set { dateM = newValue }
  }
  
  var result: Int {
    get { Int(resultM) }
    set { resultM = Int32(newValue) }
  }
}
