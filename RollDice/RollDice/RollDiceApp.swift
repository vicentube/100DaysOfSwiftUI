// RollDiceApp.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct RollDiceApp: App {
  let persistenceController = PersistenceController.shared
  @StateObject private var model = ModelFile.load()
  
  var body: some Scene {
    WindowGroup {
      ContentView(model: model)
      //.environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
