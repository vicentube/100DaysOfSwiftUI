// ModelCD.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreData

final class ModelCD: ModelBase, ModelProtocol {
  @Published var history: [RollRoundMO]
  
  let coreDataService = CoreDataService()
  
  override init(sides: Int, numOfDice: Int) {
    self.history = []
    super.init(sides: sides, numOfDice: numOfDice)
    print(FileManager.getDocumentsDirectory())
  }
  
  func loadHistory() {
    coreDataService.prepareDatabase()
    coreDataService.fetchRounds() { result in
      switch result {
      case .success(let rounds):
        self.history = rounds
      case .failure:
        self.errorMsg = ErrorMsg("Data could not be fetched")
        self.history = []
      }
    }
  }
  
  func clearHistory() {
    history.forEach(coreDataService.deleteRound)
    history = []
    saveHistory()
  }
  
  func saveHistory() {
    if !coreDataService.save() {
      errorMsg = ErrorMsg("Data could not be saved")
      return
    }
  }
  
  func createRound(_ value: Int) -> RollRoundMO {
    coreDataService.createRound(value)
  }
}
