// ModelCD.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreData

final class ModelCD: ModelBase, ModelProtocol {
  @Published var history: [RollRoundMO]
  
  private let container = NSPersistentContainer(name: "RollDice")
  private var moc: NSManagedObjectContext { container.viewContext }
  
  override init(sides: Int, numOfDice: Int) {
    self.history = []
    super.init(sides: sides, numOfDice: numOfDice)
  }
  
  func loadHistory() {
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RollRoundMO")
    let sort = NSSortDescriptor(key: "dateM", ascending: false)
    request.sortDescriptors = [sort]
    if let rounds = try? moc.fetch(request) as? [RollRoundMO] {
      history = rounds
    } else {
      errorMsg = ErrorMsg("Data could not be fetched")
      history = []
    }
  }
  
  func clearHistory() {
    history.forEach(moc.delete)
    history = []
    saveHistory()
  }
  
  func saveHistory() {
    if moc.hasChanges {
      do {
        try moc.save()
      } catch {
        print(error.localizedDescription)
        errorMsg = ErrorMsg("Data counld not be saved")
      }
    }
  }
  
  func createRound(_ value: Int) -> RollRoundMO {
    let round = RollRoundMO(context: moc)
    round.date = Date()
    round.result = value
    return round
  }
}
