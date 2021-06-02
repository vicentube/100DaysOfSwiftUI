// PersistenceProtocol.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

protocol PersistenceProtocol {
  func loadHistory() -> [RollRound]?
  func saveRound(_ round: RollRound) -> Bool
  func clearHistory(_ history: [RollRound]) -> Bool
}
