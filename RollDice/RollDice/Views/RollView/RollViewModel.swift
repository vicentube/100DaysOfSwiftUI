// RollViewModel.swift
// RollDice
//
// Creado el 6/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class RollViewModel: ObservableObject {
  @Published var rolling = false
  
  private(set) var model: AppModel!
  
  private let hapticService = HapticsService()
  
  func initViewModel(model: AppModel) {
    self.model = model
  }
  
  func onSettingsTap() {
    model.showingSettings = true
  }
  
  func onRollButtonTap() {
    hapticService.prepare()
    let rollSteps = 20
    model.hiddenDice = false
    let initialValues = [Int].init(repeating: 0, count: model.settings.numOfDice)
    let finalValues = initialValues.map { _ in Int.random(in: 1...model.settings.sides) }
    let finalTotal = finalValues.reduce(0, +)
    hapticService.rollingEffect()
    for runCount in 1...rollSteps {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(runCount) * 0.1) {
        self.rolling = true
        self.hapticService.prepare()
        if runCount == rollSteps {
          self.rolling = false
          self.model.diceValues = finalValues
          self.hapticService.rollingEffect()
          return
        }
        self.model.diceValues = initialValues.map { _ in Int.random(in: 1...self.model.settings.sides) }
      }
    }
    saveRound(finalTotal)
  }
  
  private func saveRound(_ value: Int) {
    let round = RollRound(value)
    model.dataService.addRound(round)
    model.history.insert(round, at: 0)
  }
}
