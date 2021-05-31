// AppState.swift
// RollDice
//
// Creado el 31/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Combine

final class AppState: ObservableObject {
  @Published var settings = Settings()
  @Published var errorMsg: ErrorMsg? = nil
}
