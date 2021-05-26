// HistoryViewModel.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct HistoryView<T: AppModel> {
  @ObservedObject private var model: T
  
  init(model: T) {
    self.model = model
  }
}
