// UserDefaults-ValueExists.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

extension UserDefaults {
  func valueExists(forKey key: String) -> Bool {
    object(forKey: key) != nil
  }
}
