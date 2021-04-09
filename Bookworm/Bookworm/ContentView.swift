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
  @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
  
  @State private var showingAddScreen = false
  
  var body: some View {
    NavigationView {
      Text("Count: \(books.count)")
        .navigationBarTitle("Bookworm")
        .navigationBarItems(trailing: Button(action: { showingAddScreen.toggle() }) {
          Image(systemName: "plus")
        })
        .sheet(isPresented: $showingAddScreen) {
          AddBookView()
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static let persistenceController = PersistenceController.shared
  
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
  }
}
