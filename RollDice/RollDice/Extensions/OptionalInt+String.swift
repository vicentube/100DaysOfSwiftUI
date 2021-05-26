// OptionalInt+String.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

extension Optional where Wrapped: BinaryInteger {
  var string: String { self.map { String($0) } ?? "" }
}
