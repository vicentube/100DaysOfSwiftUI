// SettingsViewModel.swift
// RollDice
//
// Creado el 6/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class SettingsViewModel: ObservableObject {
  private(set) var model: AppModel!
  
  func initViewModel(model: AppModel) {
    self.model = model
  }
  
  func onDoneTap() {
    model.settingsService.save(model.settings)
    model.resetDice()
    model.showingSettings = false
  }
}
