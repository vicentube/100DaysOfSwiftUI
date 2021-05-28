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
  var rolling: Bool { get set }
  
  init(sides: Int, numOfDice: Int)
  func createRound(_ value: Int) -> RollRoundType
  func rollDice(onTick: @escaping () -> Void)
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
  
  func rollDice(onTick: @escaping () -> Void) {
    rolling = true
    let rolledDice = [Int].init(repeating: 0, count: numOfDice)
    for runCount in 1...40 {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 * Double(runCount)) {
        self.lastRoll = rolledDice.map { _ in Int.random(in: 1...self.sides) }
        onTick()
        if runCount == 40 {
          self.rolling = false
          if let lastRollTotal = self.lastRollTotal {
            let round = self.createRound(lastRollTotal)
            self.history.insert(round, at: 0)
            self.saveHistory()
          }
        }
      }
    }
  }
}
