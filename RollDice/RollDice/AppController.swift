// AppController.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

protocol AppControllerProtocol {
  var appState: AppState { get }
  var contentViewInteractor: ContentView.Interactor { get }
  var rollViewInteractor: RollView.Interactor { get }
  var settingsViewInteractor: SettingsView.Interactor { get }
}

final class AppController: AppControllerProtocol {
  private(set) var appState: AppState
  
  init(appState: AppState) {
    self.appState = appState
  }
  
  var contentViewInteractor: ContentView.Interactor {
    ContentView.Interactor(appState: appState, settingsService: SettingsService())
  }
  
  var rollViewInteractor: RollView.Interactor {
    RollView.Interactor(appState: appState, persistence: CoreDataPersistence())
  }
  
  var settingsViewInteractor: SettingsView.Interactor {
    SettingsView.Interactor(appState: appState, settingsService: SettingsService())
  }
}

final class PreviewAppController: AppControllerProtocol {
  private(set) var appState: AppState
  
  init(appState: AppState) {
    self.appState = appState
  }
  
  var contentViewInteractor: ContentView.Interactor {
    ContentView.Interactor(appState: appState, settingsService: PreviewSettingsService())
  }
  
  var rollViewInteractor: RollView.Interactor {
    RollView.Interactor(appState: appState, persistence: FakePersistence())
  }
  
  var settingsViewInteractor: SettingsView.Interactor {
    SettingsView.Interactor(appState: appState, settingsService: PreviewSettingsService())
  }
}
