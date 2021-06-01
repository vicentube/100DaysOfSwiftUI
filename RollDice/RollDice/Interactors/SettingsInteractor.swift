// SettingsInteractor.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

protocol SettingsInteractorProtocol {
  func loadSettings()
  func saveSettings(presentationMode: Binding<PresentationMode>)
}

struct SettingsInteractor: SettingsInteractorProtocol {
  let appState: AppState
  
  init(appState: AppState) {
    self.appState = appState
  }
  
  func loadSettings() {
    if UserDefaults.standard.valueExists(forKey: "Sides") {
      appState.settings.sides = UserDefaults.standard.integer(forKey: "Sides")
    }
    if UserDefaults.standard.valueExists(forKey: "NumOfDice") {
      appState.settings.numOfDice = UserDefaults.standard.integer(forKey: "NumOfDice")
    }
  }
  
  func saveSettings(presentationMode: Binding<PresentationMode>) {
    UserDefaults.standard.set(appState.settings.sides, forKey: "Sides")
    UserDefaults.standard.set(appState.settings.numOfDice, forKey: "NumOfDice")
    presentationMode.wrappedValue.dismiss()
  }
}

struct StubSettingsInteractor: SettingsInteractorProtocol {
  func loadSettings() {

  }
  
  func saveSettings(presentationMode: Binding<PresentationMode>) {

  }
}
