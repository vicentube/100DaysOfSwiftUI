// InteractorContainer.swift
// RollDice
//
// Creado el 31/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class InteractorContainer: ObservableObject {
  let contentView: ContentViewInteractor
  
  init(appState: AppState) {
    self.contentView = ContentViewInteractor(appState: appState)
  }
}
