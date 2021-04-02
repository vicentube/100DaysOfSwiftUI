// DetailHabitView.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct DetailHabitView: View {
  @ObservedObject var store: HabitStore
  @State private var descriptionText = ""
  
  let habit: Habit
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        Text("Description")
          .font(.headline)
        TextField("Habit description", text: $descriptionText, onCommit: {
          if let index = store.habits.firstIndex(where: { $0.id == habit.id }) {
            store.habits[index].description = descriptionText
          }
        })
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
    .onAppear(perform: { descriptionText = habit.description })
  }
  
  func habitCompleted() {
    if let index = store.habits.firstIndex(where: { $0.id == habit.id }) {
      store.habits[index].timesCompleted += 1
    }
  }
}

struct DetailHabitView_Previews: PreviewProvider {
  static let store = HabitStore()
  
  static var previews: some View {
    DetailHabitView(store: store, habit: Habit(title: "Test"))
  }
}
