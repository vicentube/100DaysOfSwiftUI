// ModelPreview.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class ModelPreview: ModelBase, ModelProtocol {
  var errorMsg: ErrorMsg?
  
  @Published var history: [RollRoundFile]
  
  override init(sides: Int = 6, numOfDice: Int = 1) {
    self.history = [
      RollRoundFile(1),
      RollRoundFile(2),
      RollRoundFile(3),
      RollRoundFile(4),
      RollRoundFile(5),
      RollRoundFile(6)
    ]
    super.init(sides: sides, numOfDice: numOfDice)
  }
  
  required init(from decoder: Decoder) throws {
    fatalError("init(from:) has not been implemented")
  }
  
  func clearHistory() {
    history = [RollRoundFile]()
  }
  
  func saveData() { }
}
