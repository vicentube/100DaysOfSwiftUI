// PreviewDataService.swift
// RollDice
//
// Creado el 6/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

final class PreviewDataService: DataServiceProtocol {
  func addRound(_ round: RollRound) { }
  func fetchHistory() -> [RollRound] { return [] }
  func clearHistory() { }
}
