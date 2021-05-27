// ModelFile.swift
// RollDice
//
// Creado el 25/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class ModelFile: ModelBase, Model {
  @Published var history: [RollRoundFile]
  @Published var errorMsg: String?
  
  static let url = FileManager.getDocumentsDirectory().appendingPathComponent("app_data")
  
  override init(sides: Int = 6, numOfDice: Int = 1) {
    self.history = [RollRoundFile]()
    super.init(sides: sides, numOfDice: numOfDice)
  }
  
  func clearHistory() {
    history = [RollRoundFile]()
    saveData()
  }
  
  func saveData() {
    guard let data = try? JSONEncoder().encode(self) else {
      errorMsg = "Data could not be encoded"
      return
    }
    do {
      try data.write(to: ModelFile.url, options: [.atomicWrite, .completeFileProtection])
    } catch {
      errorMsg = "Data could not be written to disk"
      print(error.localizedDescription)
    }
  }
  
  // - MARK: Codable
  enum CodingKeys: CodingKey {
    case history
  }
  
  override func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
  
    try container.encode(history, forKey: .history)
    
    let superEncoder = container.superEncoder()
    try super.encode(to: superEncoder)
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let superDecoder = try container.superDecoder()
    
    history = try container.decode([RollRoundFile].self, forKey: .history)
    try super.init(from: superDecoder)
  }
  
  static func load() -> ModelFile {
    if let data = try? Data(contentsOf: url) {
      if let decoded = try? JSONDecoder().decode(ModelFile.self, from: data) {
        return decoded
      }
    }
    
    return ModelFile()
  }
}
