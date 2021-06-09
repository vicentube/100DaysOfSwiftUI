// SettingsViewModel.swift
// RollDice
//
// Creado el 6/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

extension SettingsView {
  final class ViewModel: ObservableObject {
    private let model = AppModel.shared
    var cancellable : AnyCancellable? = nil
    
    @Published var settings = Settings()
    
    let possibleSides: [Int] = [4, 6, 8, 10, 12, 20, 100]
    
    init() {
      settings = model.settings
      cancellable = self.model.objectWillChange.sink { [weak self] _ in
        self?.objectWillChange.send()
      }
    }
  }
}
