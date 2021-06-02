// RollInteractor.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

protocol RollInteractorProtocol {
  func rollDice(viewState: Binding<RollView.ViewState>)
  func saveSettings()
}

struct RollInteractorKey: EnvironmentKey {
  static var defaultValue: RollInteractorProtocol = FakeRollInteractor()
}

extension EnvironmentValues {
  var rollInteractor: RollInteractorProtocol {
    get { self[RollInteractorKey.self] }
    set { self[RollInteractorKey.self] = newValue }
  }
}

struct RollInteractor: RollInteractorProtocol {
  private let appState: AppState
  private let persistence: PersistenceProtocol
  
  private let hapticService = HapticsService()
  
  init(appState: AppState, persistence: PersistenceProtocol) {
    self.appState = appState
    self.persistence = persistence
  }
  
  func rollDice(viewState: Binding<RollView.ViewState>) {
    let rollSteps = 25
    viewState.wrappedValue.rolling = true
    let initialValues = [Int].init(repeating: 0, count: appState.numOfDice)
    let finalValues = initialValues.map { _ in Int.random(in: 1...self.appState.sides) }
    let finalTotal = finalValues.reduce(0, +)
    viewState.wrappedValue.totalValue = finalTotal
    for runCount in 1...rollSteps {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(runCount) * 0.1) {
        self.hapticService?.rollDiceEffect()
        if runCount == rollSteps {
          viewState.wrappedValue.rolling = false
          viewState.wrappedValue.diceValues = finalValues
          return
        }
        viewState.wrappedValue.diceValues = initialValues.map { _ in Int.random(in: 1...self.appState.sides) }
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
  
  func saveSettings() {
    UserDefaults.standard.set(appState.sides, forKey: "Sides")
    UserDefaults.standard.set(appState.numOfDice, forKey: "NumOfDice")
  }
}

struct FakeRollInteractor: RollInteractorProtocol {
  func rollDice(viewState: Binding<RollView.ViewState>) { }
  func saveSettings() { }
}
