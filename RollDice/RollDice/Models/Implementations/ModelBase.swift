// ModelBase.swift
// RollDice
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

class ModelBase: ObservableObject {
  @Published var sides: Int
  @Published var numOfDice: Int
  @Published var lastRoll: [Int]?
  @Published var errorMsg: ErrorMsg?
  
  let possibleSides: [Int] = [4, 6, 8, 10, 12, 20, 100]
  
  init(sides: Int, numOfDice: Int) {
    self.sides = sides
    self.numOfDice = numOfDice
    self.lastRoll = nil
    self.errorMsg = nil
  }
}
