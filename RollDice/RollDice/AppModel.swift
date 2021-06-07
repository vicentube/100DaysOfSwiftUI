// AppModel.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class AppModel: ObservableObject {
  @Published var settings = Settings()
  @Published var diceValues = [0]
  @Published var hiddenDice = true
  @Published var showingSettings = false
  @Published var history: [RollRound] = []
  
  let possibleSides: [Int] = [4, 6, 8, 10, 12, 20, 100]
  
  let dataService: DataServiceProtocol
  let settingsService: SettingsServiceProtocol
  
  init(dataService: DataServiceProtocol, settingsService: SettingsServiceProtocol) {
    self.dataService = dataService
    self.settingsService = settingsService
    settings = settingsService.load()
    resetDice()
    history = dataService.fetchHistory()
  }
  
  var diceInfoText: String {
    let dieOrDice = settings.numOfDice == 1 ? "die" : "dice"
    return "Rolling \(settings.numOfDice) \(dieOrDice) (\(settings.sides)-sided)..."
  }
  
  var totalValue: Int {
    diceValues.reduce(0, +)
  }
  
  func resetDice() {
    diceValues = [Int].init(repeating: 0, count: settings.numOfDice)
    hiddenDice = true
  }
}

extension AppModel {
  static var app: AppModel {
    AppModel(dataService: CoreDataService(), settingsService: SettingsService())
  }
}
