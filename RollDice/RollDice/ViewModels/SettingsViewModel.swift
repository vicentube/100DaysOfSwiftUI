// SettingsViewModel.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct SettingsView<T: ModelProtocol> {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var model: T
  
  func saveSettings() {
    model.saveData()
    presentationMode.wrappedValue.dismiss()
  }
}
