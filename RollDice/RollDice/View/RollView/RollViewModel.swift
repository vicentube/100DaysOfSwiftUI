// RollViewModel.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollViewModel<T: AppModel> {
  @ObservedObject private var model: T
  
  var sides: String { "\(model.sides)" }
  var lastRoll: String { model.lastRoll.map { String($0) } ?? "" }
  
  init(model: T) {
    self.model = model
  }
  
  func rollDice() { model.rollDice() }
}
