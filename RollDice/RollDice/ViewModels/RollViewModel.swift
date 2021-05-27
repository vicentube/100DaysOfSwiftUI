// RollViewModel.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView<T: Model> {
  @ObservedObject var model: T
  
  @State var showingSettings = false
  
  var noDiceText: String {
    "Ready to roll \(model.numOfDice) \(model.numOfDice == 1 ? "die" : "dice") (\(model.sides)-sided)..."
  }
  
  func showSettings() {
    showingSettings = true
  }
}
