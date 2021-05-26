// RollRoundFile.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct RollRoundFile: RollRound {
  var id: UUID
  var result: Int
  
  init(_ result: Int) {
    self.id = UUID()
    self.result = result
  }
}
