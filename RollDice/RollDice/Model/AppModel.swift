// AppModel.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

protocol AppModel: ObservableObject {
  associatedtype RollRoundType: RollRound
  
  var sides: Int { get set }
  var lastRoll: Int? { get set }
  var history: [RollRoundType] { get set }
}

extension AppModel {
  func rollDice() {
    let roll = Int.random(in: 1...sides)
    let round = RollRoundType(roll)
    history.append(round)
    lastRoll = roll
  }
}

//final class AppModel: ObservableObject {
//  @Published var sides: Int
//  @Published var lastRoll: Int?
//
//  private var dataService: DataService
//
//  init(sides: Int = 6) {
//    self.sides = sides
//    self.lastRoll = nil
//    self.history = [TData]()
//  }
//
//  func rollDice() {
//    let roll = Int.random(in: 1...sides)
//    let round = TData(roll)
//    history.append(round)
//    lastRoll = roll
//  }
//}
