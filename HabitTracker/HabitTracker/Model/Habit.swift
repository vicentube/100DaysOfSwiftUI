// Habit.swift
// HabitTracker
//
// Creado el 1/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Habit: Identifiable, Codable {
  let id: UUID
  let title: String
  var description: String 
  var timesCompleted: Int = 0
  
  init(id: UUID = UUID(), title: String, description: String = "", timesCompleted: Int = 0) {
    self.id = id
    self.title = title
    self.description = description
    self.timesCompleted = timesCompleted
  }
}
