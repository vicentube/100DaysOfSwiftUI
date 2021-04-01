// DetailHabitView.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct DetailHabitView: View {
  @ObservedObject var store: HabitStore
  var index: Int
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        Text("Description")
          .font(.headline)
        TextField("Habit description", text: $store.habits[index].description)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        HStack {
          Text("Times completed")
          Spacer()
          Text("\(store.habits[index].timesCompleted)")
        }
        .font(.title)
      }
      Button(action: { store.habits[index].timesCompleted += 1 }) {
        Image(systemName: "goforward.plus")
          .font(.system(size: 75, weight: .bold, design: .rounded))
      }
      .padding()
      Spacer()
    }
    .padding()
    .navigationBarTitle(store.habits[index].title)
  }
}

struct DetailHabitView_Previews: PreviewProvider {
  static let store = HabitStore()
  
  static var previews: some View {
    DetailHabitView(store: store, index: 0)
  }
}
