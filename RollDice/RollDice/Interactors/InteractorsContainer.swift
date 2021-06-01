// InteractorsContainer.swift
// RollDice
//
// Creado el 31/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct InteractorsContainer: EnvironmentKey {
  let settings: SettingsInteractorProtocol
  let roll: RollInteractorProtocol
  let history: HistoryInteractorProtocol
  
  init(settings: SettingsInteractorProtocol,
       roll: RollInteractorProtocol,
       history: HistoryInteractorProtocol) {
    self.settings = settings
    self.roll = roll
    self.history = history
  }
  
  static var stub: Self {
    .init(settings: StubSettingsInteractor(),
          roll: StubRollInteractor(),
          history: StubHistoryInteractor())
  }
}

