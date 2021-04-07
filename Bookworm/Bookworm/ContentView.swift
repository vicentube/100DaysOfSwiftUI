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
  
  @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
  
  var body: some View {
    VStack {
      List {
        ForEach(students, id: \.id) { student in
          Text(student.name ?? "Unknown")
        }
      }
      Button("Add") {
        let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
        let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
        
        let chosenFirstName = firstNames.randomElement()!
        let chosenLastName = lastNames.randomElement()!
        
        let student = Student(context: self.moc)
        student.id = UUID()
        student.name = "\(chosenFirstName) \(chosenLastName)"
        
        try? moc.save()
      }
    }
  }
  
  private func addItem() {
    withAnimation {
      let newItem = Student(context: moc)
      newItem.name = "Hello world!"
      
      do {
        try moc.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { students[$0] }.forEach(moc.delete)
      
      do {
        try moc.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
