// FilePersistenceService.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class FilePersistenceService: PersistenceServiceProtocol {
  let url = FileManager.getDocumentsDirectory().appendingPathComponent("app_data")
  
  func loadHistory() -> [RollRound]? {
    if let data = try? Data(contentsOf: url) {
      if let decoded = try? JSONDecoder().decode([RollRound].self, from: data) {
        return decoded
      }
    }
    return nil
  }
  
  func saveRound(_ round: RollRound) -> Bool {
    guard var history = loadHistory() else { return false }
    history.insert(round, at: 0)
    guard let data = try? JSONEncoder().encode(history) else { return false }
    do {
      try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
      return true
    } catch {
      print(error.localizedDescription)
      return false
    }
  }
  
  func clearHistory() -> Bool {
    guard let data = try? JSONEncoder().encode([RollRound]()) else { return false }
    do {
      try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
      return true
    } catch {
      print(error.localizedDescription)
      return false
    }
  }
}
