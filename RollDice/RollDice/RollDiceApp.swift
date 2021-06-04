// RollDiceApp.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct RollDiceApp: App {
  private let controller: AppController
  
  init() {
    let appState = AppState()
    let persistenceService = CoreDataPersistenceService()
    let settingsService = SettingsService()
    self.controller = AppController(
      appState: appState,
      persistenceService: persistenceService,
      settingsService: settingsService)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView(controller)
    }
  }
}
