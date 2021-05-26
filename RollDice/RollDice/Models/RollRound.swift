// RollRound.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

protocol RollRound: Codable, Identifiable {
  var id: UUID { get }
  var result: Int { get set }
  
  init(_ result: Int)
}
