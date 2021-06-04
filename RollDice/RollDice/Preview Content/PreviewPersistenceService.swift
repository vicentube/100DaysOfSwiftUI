// PreviewPersistenceService.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

final class PreviewPersistenceService: PersistenceServiceProtocol {
  func loadHistory() -> [RollRound]? {
    return [RollRound]()
  }
  
  func saveRound(_ round: RollRound) -> Bool {
    return true
  }
  
  func clearHistory() -> Bool {
    return true
  }
}
