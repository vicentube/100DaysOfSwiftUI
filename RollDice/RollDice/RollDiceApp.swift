// RollDiceApp.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct RollDiceApp: App {
  static var controller: AppControllerProtocol = RollDiceApp.app
  
  @StateObject private var appState = controller.appState
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appState)
    }
  }
}

extension RollDiceApp {
  static var app: AppController {
    AppController(appState: AppState())
  }
  
  static var preview: PreviewAppController {
    PreviewAppController(appState: AppState())
  }
}
