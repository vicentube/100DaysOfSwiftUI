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
  private(set) var contentViewInteractor: ContentView.Interactor
  private(set) var rollViewInteractor: RollView.Interactor
  private(set) var settingsViewInteractor: SettingsView.Interactor
  private(set) var historyViewInteractor: HistoryView.Interactor
  
  init(appState: AppState,
       persistenceService: PersistenceServiceProtocol,
       settingsService: SettingsServiceProtocol) {
    
    self.appState = appState
    
    self.contentViewInteractor = ContentView.Interactor(
      appState: appState,
      settingsService: settingsService,
      persistenceService: persistenceService)
    
    self.rollViewInteractor = RollView.Interactor(
      appState: appState,
      persistenceService: persistenceService)
    
    self.settingsViewInteractor = SettingsView.Interactor(
      appState: appState,
      settingsService: settingsService)
    
    self.historyViewInteractor = HistoryView.Interactor(
      appState: appState,
      persistenceService: persistenceService)
  }
}
