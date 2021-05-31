// RollViewInteractor.swift
// RollDice
//
// Creado el 31/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

protocol RollViewInteractorProtocol {
  var errorMsg: Binding<ErrorMsg?> { get set }
}

final class RollViewInteractor: RollViewInteractorProtocol {
  let appState: AppState
  var errorMsg: Binding<ErrorMsg?>
  
  private let hapticService = HapticsService()
  
  init(appState: AppState) {
    self.appState = appState
    
    errorMsg = Binding(
      get: { appState.errorMsg },
      set: { appState.errorMsg = $0 }
    )
  }
  
  private func onTapRollDice() {
    var count = 1
    appState.rollDice() {
      hapticService?.rollDiceEffect()
      rotation = .degrees(Double((count * 20) % 360))
      count += 1
    }
  }
}
