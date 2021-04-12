// ContentView.swift
// CoreDataProject
//
// Creado el 12/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreData

struct Student: Hashable {
  let name: String
}

struct ContentView: View {
  let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
  
  var body: some View {
    List(students, id: \.self) { student in
      Text(student.name)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
