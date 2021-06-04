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
  
  @ObservedObject private var appState = controller.appState
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

extension RollDiceApp {
  static var app: AppController {
    AppController()
  }
}
