// ModelFile.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class ModelFile: ModelBase, ModelProtocol {
  @Published var history: [RollRoundFile]
  
  let url = FileManager.getDocumentsDirectory().appendingPathComponent("app_data")
  
  override init(sides: Int, numOfDice: Int) {
    self.history = []
    super.init(sides: sides, numOfDice: numOfDice)
  }
  
  func loadHistory() {
    if let data = try? Data(contentsOf: url) {
      if let decoded = try? JSONDecoder().decode([RollRoundFile].self, from: data) {
        history = decoded
        return
      }
    }
    
    errorMsg = ErrorMsg("Data could not be loaded")
  }
  
  func clearHistory() {
    history = []
    saveHistory()
  }
  
  func saveHistory() {
    guard let data = try? JSONEncoder().encode(history) else {
      errorMsg = ErrorMsg("History could not be encoded")
      return
    }
    do {
      try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
    } catch {
      errorMsg = ErrorMsg("History could not be written to disk")
      print(error.localizedDescription)
    }
  }
  
  func createRound(_ value: Int) -> RollRoundFile {
    RollRoundFile(value)
  }
}

// - MARK: Codable
extension ModelFile: Codable {
  enum CodingKeys: CodingKey {
    case history
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(history, forKey: .history)
  }
  
  convenience init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    history = try container.decode([RollRoundFile].self, forKey: .history)
  }
}
