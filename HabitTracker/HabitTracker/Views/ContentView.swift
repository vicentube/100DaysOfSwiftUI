// ContentView.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @ObservedObject private var store = HabitStore()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(store.habits) { habit in
          Text(habit.title)
        }
      }
      .navigationBarTitle("Habit Tracker")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
