// ModelPreview.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class ModelPreview: ObservableObject, Model {
  @Published var sides: Int
  @Published var lastRoll: Int?
  @Published var history: [RollRoundFile]
  
  init() {
    self.sides = 6
    self.lastRoll = nil
    self.history = [
      RollRoundFile(1),
      RollRoundFile(2),
      RollRoundFile(3),
      RollRoundFile(4),
      RollRoundFile(5),
      RollRoundFile(6)
    ]
  }
}
