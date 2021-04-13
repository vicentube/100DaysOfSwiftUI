// ContentView.swift
// CoreDataProject
//
// Creado el 12/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: nil) var ships: FetchedResults<Ship>
  // NSPredicate(format: "universe == 'Star Wars'")
  // NSPredicate(format: "universe == %@", "Star Wars")
  // NSPredicate(format: "name < %@", "F")
  // NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
  // NSPredicate(format: "name BEGINSWITH %@", "E"))
  // NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
  // NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
  
  var body: some View {
    VStack {
      List(ships, id: \.self) { ship in
        Text(ship.name ?? "Unknown name")
      }
      
      Button("Add Examples") {
        let ship1 = Ship(context: self.moc)
        ship1.name = "Enterprise"
        ship1.universe = "Star Trek"
        
        let ship2 = Ship(context: self.moc)
        ship2.name = "Defiant"
        ship2.universe = "Star Trek"
        
        let ship3 = Ship(context: self.moc)
        ship3.name = "Millennium Falcon"
        ship3.universe = "Star Wars"
        
        let ship4 = Ship(context: self.moc)
        ship4.name = "Executor"
        ship4.universe = "Star Wars"
        
        try? self.moc.save()
      }
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
