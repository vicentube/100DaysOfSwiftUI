// Habit.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Habit: Identifiable {
  let id = UUID()
  var title: String
  var description: String 
  var timesCompleted: Int = 0
}
