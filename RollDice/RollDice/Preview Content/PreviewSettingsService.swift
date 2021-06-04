// PreviewSettingsService.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

final class PreviewSettingsService: SettingsServiceProtocol {
  func load() -> Settings {
    Settings(sides: 6, numOfDice: 2)
  }
  
  func save(_ settings: Settings) { }
}
