// CoreDataPersistence.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreData

final class CoreDataPersistence: PersistenceProtocol {
  
  private let container = NSPersistentContainer(name: "RollDice")
  private var moc: NSManagedObjectContext { container.viewContext }
  
  init() {
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
  }
  
  func loadHistory() -> [RollRound]? {
    let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RollRoundMO")
    let sort = NSSortDescriptor(key: "dateM", ascending: false)
    request.sortDescriptors = [sort]
    
    do {
      let rounds = try moc.fetch(request) as! [RollRoundMO]
      let history = rounds.map { $0.convertToDto() }
      return history
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
  
  func saveRound(_ round: RollRound) -> Bool {
    let _ = RollRoundMO.createFromDto(round, context: moc)
    do {
      try moc.save()
      return true
    } catch {
      print(error.localizedDescription)
      return false
    }
  }
  
  func clearHistory(_ history: [RollRound]) -> Bool {
    let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RollRoundMO")
    do {
      let rounds = try moc.fetch(request) as! [RollRoundMO]
      rounds.forEach(moc.delete)
      try moc.save()
      return true
    } catch {
      print(error.localizedDescription)
      return false
    }
  }
}

extension RollRoundMO {
  func convertToDto() -> RollRound {
    RollRound(Int(valueM))
  }
  
  func convertFromDto(_ dto: RollRound) {
    dateM = dto.id
    valueM = Int32(dto.value)
  }
  
  static func createFromDto(_ dto: RollRound, context: NSManagedObjectContext) -> RollRoundMO {
    let round = RollRoundMO(context: context)
    round.convertFromDto(dto)
    return round
  }
}

