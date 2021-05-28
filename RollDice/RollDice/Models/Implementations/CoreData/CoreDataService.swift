// CoreDataService.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import CoreData

final class CoreDataService {
  let container = NSPersistentContainer(name: "RollDice")
  
  private var moc: NSManagedObjectContext { container.viewContext }
  
  func prepareDatabase() {
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
  }
  
  func fetchRounds(completion: @escaping (Result<[RollRoundMO], Error>) -> Void) {
    let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RollRoundMO")
    let sort = NSSortDescriptor(key: "dateM", ascending: false)
    request.sortDescriptors = [sort]
    do {
      let rounds = try moc.fetch(request) as! [RollRoundMO]
      completion(.success(rounds))
    } catch {
      completion(.failure(error))
    }
    
  }
  
  func deleteRound(_ round: RollRoundMO) {
    moc.delete(round)
  }
  
  func save() -> Bool {
    if moc.hasChanges {
      do {
        try moc.save()
        return true
      } catch {
        print(error.localizedDescription)
        return false
      }
    }
    return true
  }
  
  func createRound(_ value: Int) -> RollRoundMO {
    let round = RollRoundMO(context: moc)
    round.date = Date()
    round.result = value
    return round
  }
}
