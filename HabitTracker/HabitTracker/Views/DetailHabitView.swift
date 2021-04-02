// DetailHabitView.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct DetailHabitView: View {
  @ObservedObject var store: HabitStore
  
  let habit: Habit
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        Text("Description")
          .font(.headline)
        TextField("Habit description", text: getDescriptionBinding())
        .textFieldStyle(RoundedBorderTextFieldStyle())
        HStack {
          Text("Times completed")
          Spacer()
          Text("\(habit.timesCompleted)")
        }
        .font(.title)
      }
      Button(action: habitCompleted) {
        Image(systemName: "goforward.plus")
          .font(.system(size: 75, weight: .bold, design: .rounded))
      }
      .padding()
      Spacer()
    }
    .padding()
    .navigationBarTitle(habit.title)
  }
  
  func habitCompleted() {
    if let index = store.habits.firstIndex(where: { $0.id == habit.id }) {
      store.habits[index].timesCompleted += 1
    }
  }
  
  func getDescriptionBinding() -> Binding<String> {
    let description = Binding<String>(
      get: {
        if let index = store.habits.firstIndex(where: { $0.id == habit.id }) {
          return store.habits[index].description
        } else {
          return ""
        }
      },
      set: { newValue in
        if let index = store.habits.firstIndex(where: { $0.id == habit.id }) {
          store.habits[index].description = newValue
        }
      })
    return description
  }
}

struct DetailHabitView_Previews: PreviewProvider {
  static let store = HabitStore()
  
  static var previews: some View {
    DetailHabitView(store: store, habit: Habit(title: "Test"))
  }
}
