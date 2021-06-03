// RollViewModel.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension RollView {
  final class Interactor {
    private let appState: AppState
    private let persistence: PersistenceProtocol
    
    private let hapticService = HapticsService()
    
    init(appState: AppState, persistence: PersistenceProtocol) {
      self.appState = appState
      self.persistence = persistence
    }
    
    func rollDice(_ viewState: RollView.State) {
      let rollSteps = 25
      viewState.rolling = true
      let initialValues = [Int].init(repeating: 0, count: appState.numOfDice)
      let finalValues = initialValues.map { _ in Int.random(in: 1...self.appState.sides) }
      let finalTotal = finalValues.reduce(0, +)
      viewState.totalValue = finalTotal
      for runCount in 1...rollSteps {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(runCount) * 0.1) {
          self.hapticService?.rollDiceEffect()
          if runCount == rollSteps {
            viewState.rolling = false
            viewState.diceValues = finalValues
            return
          }
          viewState.diceValues = initialValues.map { _ in Int.random(in: 1...self.appState.sides) }
        }
      }
      saveRound(finalTotal)
    }
    
    private func saveRound(_ value: Int) {
      let round = RollRound(value)
      if persistence.saveRound(round) {
        appState.history.insert(round, at: 0)
      } else {
        appState.errorMsg = ErrorMsg("Saving round failed")
      }
    }
    
    
  }
}
