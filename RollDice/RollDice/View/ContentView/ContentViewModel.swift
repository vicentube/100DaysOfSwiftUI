// ContentViewModel.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentViewModel<T: AppModel> {
  @ObservedObject private var model: T
  
  var rollView: some View { RollViewModel(model: model) }
  var historyView: some View { HistoryView(model: model) }
  
  init(model: T) {
    self.model = model
  }
  
}
