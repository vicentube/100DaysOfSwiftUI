// AppModel.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class AppModel: ObservableObject {
  static var shared: AppModel = .app
  
  @Published var settings = Settings()
  @Published var history: [RollRound] = []
  
  private let dataService: DataServiceProtocol
  private let settingsService: SettingsServiceProtocol
  
  init(dataService: DataServiceProtocol, settingsService: SettingsServiceProtocol) {
    self.dataService = dataService
    self.settingsService = settingsService
    settings = settingsService.load()
    history = dataService.fetchHistory()
  }
  
  func saveRound(_ value: Int) {
    let round = RollRound(value)
    dataService.addRound(round)
    history.insert(round, at: 0)
  }
  
  func changeSettings(settings: Settings) {
    self.settings = settings
    settingsService.save(settings)
  }
  
  func clearHistory() {
    dataService.clearHistory()
    history = []
  }
}

extension AppModel {
  static var app: AppModel {
    AppModel(dataService: CoreDataService(), settingsService: SettingsService())
  }
}
