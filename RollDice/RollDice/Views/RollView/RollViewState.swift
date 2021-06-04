// RollViewState.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension RollView {
  final class State: ObservableObject {
    @Published var rolling = false
    @Published var showingSettings = false
    @Published var showingDice = false
  }
}
