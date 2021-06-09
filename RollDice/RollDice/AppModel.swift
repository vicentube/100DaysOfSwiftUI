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
  @Published var errorMessage: ErrorMsg? = nil
  
  private let dataService: DataServiceProtocol
  private let settingsService: SettingsServiceProtocol
  
  init(dataService: DataServiceProtocol, settingsService: SettingsServiceProtocol) {
    self.dataService = dataService
    self.settingsService = settingsService
    loadSettings()
    loadHistory()
  }
  
  private func loadSettings() {
    settings = settingsService.load()
  }
  
  func changeSettings(settings: Settings) {
    self.settings = settings
    settingsService.save(settings)
  }
  
  private func loadHistory() {
    do {
      history = try dataService.fetchHistory()
    } catch {
      history = []
      print(error.localizedDescription)
      errorMessage = ErrorMsg("History data could not be loaded")
    }
  }
  
  func saveRound(_ value: Int) {
    let round = RollRound(value)
    do {
      try dataService.addRound(round)
      history.insert(round, at: 0)
    } catch {
      print(error.localizedDescription)
      errorMessage = ErrorMsg("Dice values could not be stored in history")
    }
  }
  
  func clearHistory() {
    do {
      try dataService.clearHistory()
      history = []
    } catch {
      print(error.localizedDescription)
      errorMessage = ErrorMsg("History data could not be deleted")
    }
  }
}

extension AppModel {
  static var app: AppModel {
    AppModel(dataService: CoreDataService(), settingsService: SettingsService())
  }
}
