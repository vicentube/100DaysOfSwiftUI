// AddBookView.swift
// Bookworm
//
// Creado el 8/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct AddBookView: View {
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) private var moc
  
  @State private var title = ""
  @State private var author = ""
  @State private var rating = 3
  @State private var genre = ""
  @State private var review = ""
  
  let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Name of book", text: $title)
          TextField("Author's name", text: $author)
          
          Picker("Genre", selection: $genre) {
            ForEach(genres, id: \.self) {
              Text($0)
            }
          }
        }
        
        Section {
          RatingView(rating: $rating)
          TextField("Write a review", text: $review)
        }
        
        Section {
          Button("Save") {
            let newBook = Book(context: moc)
            newBook.title = title
            newBook.author = author
            newBook.rating = Int16(rating)
            newBook.genre = genre
            newBook.review = review
            
            try? moc.save()
            presentationMode.wrappedValue.dismiss()
          }
        }
      }
      .navigationBarTitle("Add Book")
    }
  }
}

struct AddBookView_Previews: PreviewProvider {
  static var previews: some View {
    AddBookView()
  }
}
