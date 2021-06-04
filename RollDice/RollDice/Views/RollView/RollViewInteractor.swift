// RollViewModel.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

extension RollView {
  final class Interactor {
    private let appState: AppState
    private let persistenceService: PersistenceServiceProtocol
    
    private let hapticService = HapticsService()
    
    init(appState: AppState, persistenceService: PersistenceServiceProtocol) {
      self.appState = appState
      self.persistenceService = persistenceService
    }
    
    func rollDice(_ viewState: RollView.State) {
      hapticService.prepare()
      let rollSteps = 20
      viewState.showingDice = true
      viewState.rolling = true
      let initialValues = [Int].init(repeating: 0, count: appState.numOfDice)
      let finalValues = initialValues.map { _ in Int.random(in: 1...self.appState.sides) }
      let finalTotal = finalValues.reduce(0, +)
      hapticService.rollingEffect()
      for runCount in 1...rollSteps {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(runCount) * 0.1) {
          self.hapticService.prepare()
          if runCount == rollSteps {
            viewState.rolling = false
            self.appState.diceValues = finalValues
            self.hapticService.rollingEffect()
            return
          }
          self.appState.diceValues = initialValues.map { _ in Int.random(in: 1...self.appState.sides) }
        }
      }
      saveRound(finalTotal)
    }
    
    private func saveRound(_ value: Int) {
      let round = RollRound(value)
      if persistenceService.saveRound(round) {
        appState.history.insert(round, at: 0)
      } else {
        appState.errorMsg = ErrorMsg("Saving round failed")
      }
    }
  }
}
