// Game.swift
// MultiplicationTables
//
// Creado el 16/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Game {
  var tables: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  var numberOfQuestions = 10
  var questions = [(f1: Int, f2: Int)]()
  var gameActive = false
  
  mutating func fillQuestions() {
    questions.removeAll()
    if numberOfQuestions == tables.count * 10 { // All
      for f1 in tables {
        for f2 in 1...10 {
          questions.append((f1: f1, f2: f2))
        }
      }
    }
    else {
      for _ in 0..<numberOfQuestions {
        let f1 = tables.randomElement() ?? 1
        let f2 = Int.random(in: 1...10)
        questions.append((f1: f1, f2: f2))
      }
    }
    questions.shuffle()
  }
}
