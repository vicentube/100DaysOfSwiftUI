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

struct HistoryInteractorKey: EnvironmentKey {
  static var defaultValue: HistoryInteractorProtocol = FakeHistoryInteractor()
}

extension EnvironmentValues {
  var historyInteractor: HistoryInteractorProtocol {
    get { self[HistoryInteractorKey.self] }
    set { self[HistoryInteractorKey.self] = newValue }
  }
}

struct HistoryInteractor: HistoryInteractorProtocol {
  private let appState: AppState
  private let persistence: PersistenceProtocol
  
  init(appState: AppState, persistence: PersistenceProtocol) {
    self.appState = appState
    self.persistence = persistence
  }
  
  func clearHistory() {
    if persistence.clearHistory(appState.history) {
      appState.history = []
    } else {
      appState.errorMsg = ErrorMsg("Clearing history failed")
    }
  }
}

struct FakeHistoryInteractor: HistoryInteractorProtocol {
  func loadHistory() { }
  func saveRound(_ value: Int) { }
  func clearHistory() { }
}
