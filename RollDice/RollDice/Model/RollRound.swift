// RollRound.swift
// RollDice
//
// Creado el 31/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct RollRound: Identifiable, Codable {
  var id: Date
  var value: Int
  
  init(_ value: Int) {
    self.id = Date()
    self.value = value
  }
}
