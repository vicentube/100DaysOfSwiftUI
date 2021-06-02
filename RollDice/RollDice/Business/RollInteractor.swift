// RollInteractor.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

protocol RollInteractorProtocol {
  func rollDice(diceValues: Binding<[Int]?>, totalValue: Binding<Int?>, rolling: Binding<Bool>)
  func saveSettings(presentationMode: Binding<PresentationMode>)
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
  
  func rollDice(diceValues: Binding<[Int]?>, totalValue: Binding<Int?>, rolling: Binding<Bool>) {
    let rollSteps = 50
    rolling.wrappedValue = true
    let initialValues = [Int].init(repeating: 0, count: appState.numOfDice)
    let finalValues = initialValues.map { _ in Int.random(in: 1...self.appState.sides) }
    let finalTotal = finalValues.reduce(0, +)
    totalValue.wrappedValue = finalTotal
    for runCount in 1...rollSteps {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 * Double(runCount)) {
        self.hapticService?.rollDiceEffect()
        if runCount == rollSteps {
          rolling.wrappedValue = false
          diceValues.wrappedValue = finalValues
          return
        }
        diceValues.wrappedValue = initialValues.map { _ in Int.random(in: 1...self.appState.sides) }
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
  
  func saveSettings(presentationMode: Binding<PresentationMode>) {
    UserDefaults.standard.set(appState.sides, forKey: "Sides")
    UserDefaults.standard.set(appState.numOfDice, forKey: "NumOfDice")
    presentationMode.wrappedValue.dismiss()
  }
}

struct FakeRollInteractor: RollInteractorProtocol {
  func rollDice(diceValues: Binding<[Int]?>, totalValue: Binding<Int?>, rolling: Binding<Bool>) { }
  func saveSettings(presentationMode: Binding<PresentationMode>) { }
}
