// HistoryViewModel.swift
// RollDice
//
// Creado el 5/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreData

final class HistoryViewModel: ObservableObject {
  private(set) var model: AppModel!
  
  func initViewModel(model: AppModel) {
    self.model = model
  }
  
  func onClearHistoryTap() {
    model.dataService.clearHistory()
    model.history = []
  }
}
