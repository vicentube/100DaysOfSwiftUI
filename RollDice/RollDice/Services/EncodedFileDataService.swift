// EncodedFileDataService.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class EncodedFileDataService {
  var history: [RollRoundDTO]
  
  init() {
    history = [RollRoundDTO]()
  }
}
