// HabitStore.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

class HabitStore: ObservableObject {
  @Published var habits: [Habit] {
    didSet {
      if let encoded = try? JSONEncoder().encode(habits) {
        UserDefaults.standard.set(encoded, forKey: "SavedData")
      }
    }
  }
  
  init() {
    if let data = UserDefaults.standard.data(forKey: "SavedData") {
      if let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
        self.habits = decoded
        return
      }
    }
    self.habits = []
  }
  
  func deleteHabits(at offsets: IndexSet) {
    habits.remove(atOffsets: offsets)
  }
  
  func indexOf(_ habit: Habit) -> Int? {
    return habits.firstIndex(where: { $0.id == habit.id })
  }
}
