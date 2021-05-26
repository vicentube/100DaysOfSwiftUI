// ModelFile.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class ModelFile: ModelBase, Model {
  @Published var history: [RollRoundFile]
  
  override init(sides: Int = 6, numOfDice: Int = 1) {
    self.history = [RollRoundFile]()
    super.init(sides: sides, numOfDice: numOfDice)
  }
  
  func clearHistory() {
    history = [RollRoundFile]()
  }
}
