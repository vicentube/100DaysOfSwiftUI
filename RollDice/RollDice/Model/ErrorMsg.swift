// ErrorMsg.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct ErrorMsg: Identifiable {
  let id = UUID()
  let message: String
  
  init(_ message: String) {
    self.message = message
  }
}
