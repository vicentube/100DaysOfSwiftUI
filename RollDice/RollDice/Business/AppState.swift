// AppState.swift
// RollDice
//
// Creado el 31/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

final class AppState: ObservableObject {
  @Published var sides = 6
  @Published var numOfDice = 2
  @Published var history = [RollRound]()
  @Published var errorMsg: ErrorMsg? = nil
}
