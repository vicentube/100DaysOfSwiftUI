// RollInteractor.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

protocol RollInteractorProtocol {
  func rollDice(diceValues: Binding<[Int]?>, rolling: Binding<Bool>)
}

struct RollInteractor: RollInteractorProtocol {
  let appState: AppState
  
  private let hapticService = HapticsService()
  
  init(appState: AppState) {
    self.appState = appState
  }
  
  func rollDice(diceValues: Binding<[Int]?>, rolling: Binding<Bool>) {
    let rollSteps = 50
    rolling.wrappedValue = true
    let startValues = [Int].init(repeating: 0, count: appState.settings.numOfDice)
    for runCount in 1...rollSteps {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 * Double(runCount)) {
        diceValues.wrappedValue = startValues.map { _ in Int.random(in: 1...self.appState.settings.sides) }
        self.hapticService?.rollDiceEffect()
        if runCount == rollSteps {
          rolling.wrappedValue = false
          if let diceValues = diceValues.wrappedValue {
            let totalValue = diceValues.reduce(0, +)
            let round = RollRound(totalValue)
            self.appState.history.insert(round, at: 0)
            // Persist history
          }
        }
      }
    }
  }
}

struct StubRollInteractor: RollInteractorProtocol {
  func rollDice(diceValues: Binding<[Int]?>, rolling: Binding<Bool>) {
    
  }
}

