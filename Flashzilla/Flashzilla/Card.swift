// Card.swift
// Flashzilla
//
// Creado el 17/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Card {
  let prompt: String
  let answer: String
  
  static var example: Card {
    Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
  }
}
