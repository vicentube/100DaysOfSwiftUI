// AppController.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreData

protocol AppControllerProtocol {
  var appState: AppState { get }
  var contentViewInteractor: ContentView.Interactor { get }
  var rollViewInteractor: RollView.Interactor { get }
  var settingsViewInteractor: SettingsView.Interactor { get }
  var historyViewInteractor: HistoryView.Interactor { get }
}

final class AppController: AppControllerProtocol {
  private(set) var appState = AppState()
  private let persistenceService: PersistenceServiceProtocol = CoreDataPersistenceService()
  
  var contentViewInteractor: ContentView.Interactor {
    ContentView.Interactor(appState: appState, settingsService: SettingsService(), persistenceService: persistenceService)
  }
  
  var rollViewInteractor: RollView.Interactor {
    RollView.Interactor(appState: appState, persistenceService: persistenceService)
  }
  
  var settingsViewInteractor: SettingsView.Interactor {
    SettingsView.Interactor(appState: appState, settingsService: SettingsService())
  }
  
  var historyViewInteractor: HistoryView.Interactor {
    HistoryView.Interactor(appState: appState, persistenceService: persistenceService)
  }
  
  private func coreDataSetup() {
    
  }
}
