// ContentView.swift
// Bookworm
//
// Creado el 7/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var moc
  
  var body: some View {
    Text("Hello world")
  }
}

struct ContentView_Previews: PreviewProvider {
  static let persistenceController = PersistenceController.shared
  
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
  }
}
