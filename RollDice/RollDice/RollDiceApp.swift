// RollDiceApp.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreData

@main
struct RollDiceApp: App {
  @StateObject private var model = AppModel.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
