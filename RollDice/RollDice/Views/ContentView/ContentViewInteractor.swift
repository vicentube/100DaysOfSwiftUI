// ContentViewInteractor.swift
// RollDice
//
// Creado el 2/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension ContentView {
  final class Interactor {
    private let appState: AppState
    private let settingsService: SettingsServiceProtocol
    
    init(appState: AppState, settingsService: SettingsServiceProtocol) {
      self.appState = appState
      self.settingsService = settingsService
    }
    
    func loadData() {
      // Load settings
      let settings = settingsService.load()
      if let sides = settings.sides {
        appState.sides = sides
      }
      if let numOfDice = settings.numOfDice {
        appState.numOfDice = numOfDice
      }
      //loadHistory()
    }
    
    //  private func loadHistory() {
    //    if let history = appState.persistence.loadHistory() {
    //      appState.history = history
    //    } else {
    //      appState.errorMsg = ErrorMsg("Loading history failed")
    //    }
    //  }
  }
}

