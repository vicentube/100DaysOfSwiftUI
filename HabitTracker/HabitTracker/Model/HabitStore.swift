// HabitStore.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

class HabitStore: ObservableObject {
  @Published var habits: [Habit]
  
  init() {
    habits = [Habit]()
    habits.append(Habit(title: "Lectura", description: "Leer un capítulo de un libro."))
    habits.append(Habit(title: "Ejercicio", description: "Practicar algún deporte."))
  }
  
  func deleteHabits(at offsets: IndexSet) {
    habits.remove(atOffsets: offsets)
  }
  
  func indexOf(_ habit: Habit) -> Int? {
    return habits.firstIndex(where: { $0.id == habit.id })
  }
}
