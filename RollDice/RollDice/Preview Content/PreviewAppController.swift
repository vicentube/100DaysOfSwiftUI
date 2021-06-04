// PreviewAppController.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

final class PreviewAppController: AppControllerProtocol {
  private(set) var appState = AppState()
  
  var contentViewInteractor: ContentView.Interactor {
    ContentView.Interactor(appState: appState,
                           settingsService: PreviewSettingsService(),
                           persistenceService: PreviewPersistenceService())
  }
  
  var rollViewInteractor: RollView.Interactor {
    RollView.Interactor(appState: appState,
                        persistenceService: PreviewPersistenceService())
  }
  
  var settingsViewInteractor: SettingsView.Interactor {
    SettingsView.Interactor(appState: appState,
                            settingsService: PreviewSettingsService())
  }
  
  var historyViewInteractor: HistoryView.Interactor {
    HistoryView.Interactor(appState: appState,
                           persistenceService: PreviewPersistenceService())
  }
}
