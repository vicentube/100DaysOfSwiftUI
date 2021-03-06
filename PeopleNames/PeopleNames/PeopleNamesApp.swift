// PeopleNamesApp.swift
// PeopleNames
//
// Creado el 3/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct PeopleNamesApp: App {
  let persistenceController = PersistenceController.shared
  @StateObject private var store = ContactStore()
  
  var body: some Scene {
    WindowGroup {
      ContactListView(store: store)
      //            ContentView()
      //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
