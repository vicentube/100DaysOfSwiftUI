// RollViewModel.swift
// RollDice
//
// Creado el 6/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import Combine

final class RollViewModel: ObservableObject {
  private let model = AppModel.shared
  var cancellable : AnyCancellable? = nil
  
  @Published var rolling = false
  @Published var showingSettings = false
  @Published var diceValues = [0]
  @Published var hiddenDice = true
  
  private let hapticService = HapticsService()
  
  init() {
    self.cancellable = self.model.objectWillChange.sink { [weak self] _ in
      self?.objectWillChange.send()
    }
    resetDice()
  }
  
  var diceInfoText: String {
    let dieOrDice = model.settings.numOfDice == 1 ? "die" : "dice"
    return "Rolling \(model.settings.numOfDice) \(dieOrDice) (\(model.settings.sides)-sided)..."
  }
  
  var totalValue: Int {
    diceValues.reduce(0, +)
  }
  
  func resetDice() {
    diceValues = [Int].init(repeating: 0, count: model.settings.numOfDice)
    hiddenDice = true
  }
  
  func onSettingsTap() {
    showingSettings = true
  }
  
  func onRollButtonTap() {
    hapticService.prepare()
    let rollSteps = 20
    hiddenDice = false
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
          self.diceValues = finalValues
          self.hapticService.rollingEffect()
          return
        }
        self.diceValues = initialValues.map { _ in Int.random(in: 1...self.model.settings.sides) }
      }
    }
    model.saveRound(finalTotal)
  }
  
  func onSettingsChanged(_ settings: Settings) {
    model.changeSettings(settings: settings)
    resetDice()
    showingSettings = false
  }
}
