// Test1View.swift
// Flashzilla
//
// Creado el 15/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test1View: View {
  var body: some View {
    Text("Hello, World!")
      .onTapGesture(count: 2) {
        print("Double tapped!")
      }
      .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
        print("In progress: \(inProgress)!")
      }) {
        print("Long pressed!")
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Test1View()
  }
}
