// ContentViewInteractor.swift
// RollDice
//
// Creado el 2/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

extension ContentView {
  final class Interactor {
    private let appState: AppState
    private let settingsService: SettingsServiceProtocol
    private let persistenceService: PersistenceServiceProtocol
    
    init(appState: AppState, settingsService: SettingsServiceProtocol, persistenceService: PersistenceServiceProtocol) {
      self.appState = appState
      self.settingsService = settingsService
      self.persistenceService = persistenceService
    }
    
    func loadData() {
      loadSettings()
      appState.resetDice()
      loadHistory()
    }
    
    private func loadSettings() {
      let settings = settingsService.load()
      if let sides = settings.sides {
        appState.sides = sides
      }
      if let numOfDice = settings.numOfDice {
        appState.numOfDice = numOfDice
      }
    }
    
    private func loadHistory() {
      if let history = persistenceService.loadHistory() {
        appState.history = history
      } else {
        appState.errorMsg = ErrorMsg("Loading history failed")
      }
    }
  }
}

