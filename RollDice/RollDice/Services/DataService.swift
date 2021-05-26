// DataService.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

protocol DataService {
  associatedtype DataType: RollRound
  
  var history: [DataType] { get set }
}
