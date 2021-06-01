// HistoryInteractor.swift
// RollDice
//
// Creado el 31/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

protocol HistoryInteractorProtocol {
  func clearHistory()
}

struct HistoryInteractor: HistoryInteractorProtocol {
  let appState: AppState
  
  init(appState: AppState) {
    self.appState = appState
  }
  
  func clearHistory() {
    // Clear history
  }
}

struct StubHistoryInteractor: HistoryInteractorProtocol {
  func clearHistory() {
    
  }
}
