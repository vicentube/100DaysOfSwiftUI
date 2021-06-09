// HistoryViewModel.swift
// RollDice
//
// Creado el 5/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

final class HistoryViewModel: ObservableObject {
  private let model = AppModel.shared
  var cancellable : AnyCancellable? = nil
  
  init() {
    self.cancellable = self.model.objectWillChange.sink { [weak self] _ in
      self?.objectWillChange.send()
    }
  }
  
  var history: [RollRound] { model.history }
  
  func onClearHistoryTap() {
    model.clearHistory()
  }
}
