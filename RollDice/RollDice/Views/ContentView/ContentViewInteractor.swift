// ContentViewInteractor.swift
// RollDice
//
// Creado el 31/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

protocol ContentViewInteractorProtocol {
  var errorMsg: Binding<ErrorMsg?> { get set }
}

final class ContentViewInteractor: ContentViewInteractorProtocol {
  let appState: AppState
  var errorMsg: Binding<ErrorMsg?>
  
  init(appState: AppState) {
    self.appState = appState
    
    errorMsg = Binding(
      get: { appState.errorMsg },
      set: { appState.errorMsg = $0 }
    )
  }
}
