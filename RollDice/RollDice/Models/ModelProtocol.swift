// ModelProtocol.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

protocol ModelProtocol: ObservableObject {
  associatedtype RollRoundType: RollRoundProtocol
  
  var possibleSides: [Int] { get }
  var sides: Int { get set }
  var numOfDice: Int { get set }
  var lastRoll: [Int]? { get set }
  var history: [RollRoundType] { get set }
  var errorMsg: ErrorMsg? { get set }
  
  func rollDice()
  func clearHistory()
  func saveData()
}

extension ModelProtocol {
  var lastRollTotal: Int? {
    guard let lastRoll = lastRoll else { return nil }
    return lastRoll.reduce(0, +)
  }
  
  func rollDice() {
    let rolledDice = [Int].init(repeating: 0, count: numOfDice)
    lastRoll = rolledDice.map { _ in Int.random(in: 1...sides) }
    if let lastRollTotal = lastRollTotal {
      let round = RollRoundType(lastRollTotal)
      history.append(round)
      saveData()
    }
  }
}
