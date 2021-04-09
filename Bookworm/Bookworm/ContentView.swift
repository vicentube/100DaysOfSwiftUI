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
  @FetchRequest(
    entity: Book.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \Book.title, ascending: true),
      NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
  
  @State private var showingAddScreen = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(books, id: \.self) { book in
          NavigationLink(destination: DetailView(book: book)) {
            EmojiRatingView(rating: book.rating)
              .font(.largeTitle)
            
            VStack(alignment: .leading) {
              Text(book.title ?? "Unknown Title")
                .font(.headline)
              Text(book.author ?? "Unknown Author")
                .foregroundColor(.secondary)
            }
          }
        }
        .onDelete(perform: deleteBooks)
      }
      .navigationBarTitle("Bookworm")
      .navigationBarItems(
        leading: EditButton(),
        trailing: Button(action: { showingAddScreen.toggle() }) {
          Image(systemName: "plus")
        })
      .sheet(isPresented: $showingAddScreen) {
        AddBookView()
      }
    }
  }
  
  func deleteBooks(at offsets: IndexSet) {
    for offset in offsets {
      // find this book in our fetch request
      let book = books[offset]
      
      // delete it from the context
      moc.delete(book)
    }
    
    // save the context
    try? moc.save()
  }
}

struct ContentView_Previews: PreviewProvider {
  static let persistenceController = PersistenceController.shared
  
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
  }
}
