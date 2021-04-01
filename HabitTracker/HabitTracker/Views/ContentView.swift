// ContentView.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @ObservedObject private var store = HabitStore()
  
  @State private var showingAddForm = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(store.habits) { habit in
          Text(habit.title)
        }
        .onDelete(perform: store.deleteHabits)
      }
      .navigationBarTitle("Habit Tracker")
      .navigationBarItems(
        leading: EditButton(),
        trailing: Button(action: { showingAddForm = true }) {
          Image(systemName: "plus")
        })
    }
    .sheet(isPresented: $showingAddForm) {
      AddHabitView(store: store)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
