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
  @State private var lastNameFilter = "A"
  
  var body: some View {
    VStack {
      FilteredList(predicate: "CONTAINS[c]", sortDescriptors: [NSSortDescriptor(keyPath: \Singer.firstName, ascending: true)], filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
        Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
      }
      
      Button("Add Examples") {
        let taylor = Singer(context: self.moc)
        taylor.firstName = "Taylor"
        taylor.lastName = "Swift"
        
        let ed = Singer(context: self.moc)
        ed.firstName = "Ed"
        ed.lastName = "Sheeran"
        
        let adele = Singer(context: self.moc)
        adele.firstName = "Adele"
        adele.lastName = "Adkins"
        
        try? self.moc.save()
      }
      
      Button("Show A") {
        self.lastNameFilter = "A"
      }
      
      Button("Show S") {
        self.lastNameFilter = "S"
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
