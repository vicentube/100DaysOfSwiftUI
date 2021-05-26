// Model.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

protocol Model: ObservableObject {
  associatedtype RollRoundType: RollRound
  
  var sides: Int { get set }
  var lastRoll: Int? { get set }
  var history: [RollRoundType] { get set }
}

extension Model {
  func rollDice() {
    let roll = Int.random(in: 1...sides)
    let round = RollRoundType(roll)
    history.append(round)
    lastRoll = roll
  }
}
