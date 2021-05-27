// ModelBase.swift
// RollDice
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

class ModelBase: ObservableObject, Codable {
  @Published var sides: Int
  @Published var numOfDice: Int
  @Published var lastRoll: [Int]?
  
  let possibleSides: [Int] = [4, 6, 8, 10, 12, 20, 100]
  
  init(sides: Int = 6, numOfDice: Int = 1) {
    self.sides = sides
    self.numOfDice = numOfDice
    self.lastRoll = nil
  }
  
  // - MARK: Codable
  enum CodingKeys: CodingKey {
    case sides, numOfDice, lastRoll
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(sides, forKey: .sides)
    try container.encode(numOfDice, forKey: .numOfDice)
    try container.encode(lastRoll, forKey: .lastRoll)
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    sides = try container.decode(Int.self, forKey: .sides)
    numOfDice = try container.decode(Int.self, forKey: .numOfDice)
    lastRoll = try container.decode([Int]?.self, forKey: .lastRoll)
  }
}
