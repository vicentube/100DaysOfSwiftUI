// CoreDataService.swift
// RollDice
//
// Creado el 6/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import CoreData

protocol DataServiceProtocol {
  func addRound(_ round: RollRound) throws
  func fetchHistory() throws -> [RollRound]
  func clearHistory() throws
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
  
  private func convertToRollRound(_ mo: RollRoundMO) -> RollRound{
    RollRound(id: mo.dateM ?? Date(), value: Int(mo.valueM))
  }
  
  private func fetchHistoryMO() throws -> [RollRoundMO] {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RollRoundMO")
    let sort = NSSortDescriptor(key: "dateM", ascending: false)
    request.sortDescriptors = [sort]
    let historyMO = try CoreDataService.moc.fetch(request) as! [RollRoundMO]
    return historyMO
  }
  
  private func save() throws {
    if CoreDataService.moc.hasChanges {
      try CoreDataService.moc.save()
    }
  }
  
  func addRound(_ round: RollRound) throws {
    let roundMO = RollRoundMO(context: CoreDataService.moc)
    roundMO.dateM = round.id
    roundMO.valueM = Int32(round.value)
    try save()
  }
  
  func fetchHistory() throws -> [RollRound] {
    let historyMO = try fetchHistoryMO()
    return historyMO.map(convertToRollRound)
  }
  
  func clearHistory() throws {
    let historyMO = try fetchHistoryMO()
    historyMO.forEach(CoreDataService.moc.delete)
    try save()
  }
}
