// ModelProtocol.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import Combine

protocol ModelProtocol: ObservableObject {
  associatedtype RollRoundType: RollRoundProtocol
  
  var possibleSides: [Int] { get }
  var sides: Int { get set }
  var numOfDice: Int { get set }
  var lastRoll: [Int]? { get set }
  var history: [RollRoundType] { get set }
  var errorMsg: ErrorMsg? { get set }
  
  init(sides: Int, numOfDice: Int)
  func createRound(_ value: Int) -> RollRoundType
  func rollDice()
  func initialLoad()
  func loadSettings()
  func saveSettings()
  func loadHistory()
  func clearHistory()
  func saveHistory()
}

extension ModelProtocol {
  var lastRollTotal: Int? {
    guard let lastRoll = lastRoll else { return nil }
    return lastRoll.reduce(0, +)
  }
  
  init() {
    self.init(sides: 6, numOfDice: 1)
    initialLoad()
  }
  
  func initialLoad() {
    loadSettings()
    loadHistory()
  }
  
  func loadSettings() {
    if UserDefaults.standard.valueExists(forKey: "Sides") {
      sides = UserDefaults.standard.integer(forKey: "Sides")
    }
    if UserDefaults.standard.valueExists(forKey: "NumOfDice") {
      numOfDice = UserDefaults.standard.integer(forKey: "NumOfDice")
    }
  }
  
  func saveSettings() {
    UserDefaults.standard.set(sides, forKey: "Sides")
    UserDefaults.standard.set(numOfDice, forKey: "NumOfDice")
  }
  
  func rollDice() {
    let rolledDice = [Int].init(repeating: 0, count: numOfDice)
    lastRoll = rolledDice.map { _ in Int.random(in: 1...sides) }
    if let lastRollTotal = lastRollTotal {
      let round = createRound(lastRollTotal)
      history.insert(round, at: 0)
      saveHistory()
    }
  }
}
