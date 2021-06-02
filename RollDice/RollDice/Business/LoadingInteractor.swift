// SettingsInteractor.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

protocol LoadingInteractorProtocol {
  func loadData()
}

struct LoadingInteractorKey: EnvironmentKey {
  static var defaultValue: LoadingInteractorProtocol = FakeLoadingInteractor()
}

extension EnvironmentValues {
  var loadingInteractor: LoadingInteractorProtocol {
    get { self[LoadingInteractorKey.self] }
    set { self[LoadingInteractorKey.self] = newValue }
  }
}

struct LoadingInteractor: LoadingInteractorProtocol {
  private let appState: AppState
  private let persistence: PersistenceProtocol
  
  init(appState: AppState, persistence: PersistenceProtocol) {
    self.appState = appState
    self.persistence = persistence
  }
  
  func loadData() {
    loadSettings()
    loadHistory()
  }
  
  private func loadSettings() {
    if UserDefaults.standard.valueExists(forKey: "Sides") {
      appState.sides = UserDefaults.standard.integer(forKey: "Sides")
    }
    if UserDefaults.standard.valueExists(forKey: "NumOfDice") {
      appState.numOfDice = UserDefaults.standard.integer(forKey: "NumOfDice")
    }
  }
  
  private func loadHistory() {
    if let history = persistence.loadHistory() {
      appState.history = history
    } else {
      appState.errorMsg = ErrorMsg("Loading history failed")
    }
  }
}

struct FakeLoadingInteractor: LoadingInteractorProtocol {
  func loadData() { }
}
