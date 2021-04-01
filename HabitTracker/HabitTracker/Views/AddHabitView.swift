// AddHabitView.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct AddHabitView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var store: HabitStore
  
  @State private var titleText = ""
  @State private var descriptionText = ""
  @State private var showingAlert = false
  
  var body: some View {
    NavigationView {
      Form {
        TextField("Habit title", text: $titleText)
        TextField("Habit description", text: $descriptionText)
      }
      .navigationBarTitle("Add new habit")
      .navigationBarItems(
        leading: Button(action: { presentationMode.wrappedValue.dismiss() }) {
          Text("Cancel")
        },
        trailing: Button(action: addHabit) {
          Text("Add")
        })
    }
    .alert(isPresented: $showingAlert) {
      Alert(
        title: Text("Error"),
        message: Text("Title can't be empty"),
        dismissButton: .default(Text("OK")))
    }
  }
  
  func addHabit() {
    guard !titleText.isEmpty else {
      showingAlert = true
      return
    }
    let newHabit = Habit(title: titleText, description: descriptionText)
    store.habits.append(newHabit)
    presentationMode.wrappedValue.dismiss()
  }
}

struct AddHabitView_Previews: PreviewProvider {
  static let store = HabitStore()
  
  static var previews: some View {
    AddHabitView(store: store)
  }
}
