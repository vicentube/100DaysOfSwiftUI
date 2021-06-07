// CoreDataService.swift
// RollDice
//
// Creado el 6/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import CoreData

protocol DataServiceProtocol {
  func addRound(_ round: RollRound)
  func fetchHistory() -> [RollRound]
  func clearHistory()
}

final class CoreDataService: DataServiceProtocol {
  static var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "RollDice")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  static var moc: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  private var historyMO = [RollRoundMO]()
  var historyss: [RollRound] {
    historyMO.map(convertToRollRound)
  }
  
  private func convertToRollRound(_ mo: RollRoundMO) -> RollRound{
    RollRound(id: mo.dateM ?? Date(), value: Int(mo.valueM))
  }
  
  private func save() throws {
    if CoreDataService.moc.hasChanges {
      try CoreDataService.moc.save()
    }
  }
  
  func addRound(_ round: RollRound) {
    let roundMO = RollRoundMO(context: CoreDataService.moc)
    roundMO.dateM = round.id
    roundMO.valueM = Int32(round.value)
    do {
      try save()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func fetchHistory() -> [RollRound] {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RollRoundMO")
    let sort = NSSortDescriptor(key: "dateM", ascending: false)
    request.sortDescriptors = [sort]
    do {
      let historyMO = try CoreDataService.moc.fetch(request) as! [RollRoundMO]
      return historyMO.map(convertToRollRound)
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
  
  func clearHistory() {
    do {
      historyMO.forEach(CoreDataService.moc.delete)
      try save()
      historyMO = []
    } catch {
      print(error.localizedDescription)
    }
  }
}
