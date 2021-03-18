// ExpenseItem.swift
// iExpense
//
// Creado el 18/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct ExpenseItem: Identifiable, Codable {
  let id = UUID()
  let name: String
  let type: String
  let amount: Int
}
