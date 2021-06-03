// AppState.swift
// RollDice
//
// Creado el 3/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

final class AppState: ObservableObject {
  @Published var sides = 6
  @Published var numOfDice = 2
  @Published var history = [RollRound]()
  @Published var errorMsg: ErrorMsg? = nil
}
