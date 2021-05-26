// AppModelFile.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class AppModelFile: ObservableObject, AppModel {
  @Published var sides: Int
  @Published var lastRoll: Int?
  @Published var history: [RollRoundDTO]
  
  init() {
    self.sides = 6
    self.lastRoll = nil
    self.history = [RollRoundDTO]()
  }
}
