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
  
  @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
  
  var body: some View {
    VStack {
      List(wizards, id: \.self) { wizard in
        Text(wizard.name ?? "Unknown")
      }
      
      Button("Add") {
        let wizard = Wizard(context: self.moc)
        wizard.name = "Harry Potter"
      }
      
      Button("Save") {
        do {
          try self.moc.save()
        } catch {
          print(error.localizedDescription)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
