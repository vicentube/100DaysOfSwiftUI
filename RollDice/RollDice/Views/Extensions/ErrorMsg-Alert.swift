// ErrorMsg-Alert.swift
// RollDice
//
// Creado el 28/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension ErrorMsg {
  var alert: Alert {
    Alert(
      title: Text("Error"),
      message: Text(message),
      dismissButton: .default(Text("OK"))
    )
  }
}
