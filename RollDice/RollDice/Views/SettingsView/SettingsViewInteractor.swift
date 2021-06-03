// SettingsViewInteractor.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

extension SettingsView {
  final class Interactor {
    private let appState: AppState
    private let settingsService: SettingsServiceProtocol
    
    init(appState: AppState, settingsService: SettingsServiceProtocol) {
      self.appState = appState
      self.settingsService = settingsService
    }
    
    func saveSettings() {
      let settings = Settings(sides: appState.sides, numOfDice: appState.numOfDice)
      settingsService.save(settings)
    }
  }
}

