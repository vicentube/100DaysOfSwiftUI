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
}
