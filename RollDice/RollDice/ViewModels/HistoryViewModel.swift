// HistoryViewModel.swift
// RollDice
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct HistoryView<T: Model> {
  @ObservedObject var model: T
}
