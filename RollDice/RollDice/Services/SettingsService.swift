// SettingsService.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

protocol SettingsServiceProtocol {
  func load() -> Settings
  func save(_ settings: Settings)
}

final class SettingsService: SettingsServiceProtocol {
  func load() -> Settings {
    var settings = Settings()
    if UserDefaults.standard.valueExists(forKey: "Sides") {
      settings.sides = UserDefaults.standard.integer(forKey: "Sides")
    }
    if UserDefaults.standard.valueExists(forKey: "NumOfDice") {
      settings.numOfDice = UserDefaults.standard.integer(forKey: "NumOfDice")
    }
    return settings
  }
  
  func save(_ settings: Settings) {
    UserDefaults.standard.set(settings.sides, forKey: "Sides")
    UserDefaults.standard.set(settings.numOfDice, forKey: "NumOfDice")
  }
}

final class PreviewSettingsService: SettingsServiceProtocol {  
  func load() -> Settings { Settings(sides: 6, numOfDice: 2) }
  func save(_ settings: Settings) { }
}
