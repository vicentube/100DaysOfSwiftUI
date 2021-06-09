// ContentViewModel.swift
// RollDice
//
// Creado el 9/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

extension ContentView {
  final class ViewModel: ObservableObject {
    private let model = AppModel.shared
    var cancellable : AnyCancellable? = nil
    
    init() {
      self.cancellable = self.model.objectWillChange.sink { [weak self] _ in
        self?.objectWillChange.send()
      }
    }
    
    var error: ErrorMsg? {
      get { model.errorMessage }
      set { model.errorMessage = newValue }
    }
  }
}
