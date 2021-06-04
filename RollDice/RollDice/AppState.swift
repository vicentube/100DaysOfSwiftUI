// AppState.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class AppState: ObservableObject {
  @Published var sides = 6
  @Published var numOfDice = 2
  @Published var history = [RollRound]()
  @Published var errorMsg: ErrorMsg? = nil
  @Published var diceValues = [0, 0]
  
  var totalValue: Int {
    diceValues.reduce(0, +)
  }
  
  func resetDice() {
    diceValues = [Int].init(repeating: 0, count: numOfDice)
  }
}
