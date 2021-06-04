// HistoryViewInteractor.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

extension HistoryView {
  final class Interactor {
    private let appState: AppState
    private let persistenceService: PersistenceServiceProtocol
    
    init(appState: AppState, persistenceService: PersistenceServiceProtocol) {
      self.appState = appState
      self.persistenceService = persistenceService
    }
    
    func clearHistory() {
      if persistenceService.clearHistory() {
        appState.history = []
      } else {
        appState.errorMsg = ErrorMsg("Clearing history failed")
      }
    }
  }
}
