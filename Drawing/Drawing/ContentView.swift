// ContentView.swift
// Drawing
//
// Creado el 23/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  var body: some View {
    Path { path in
      path.move(to: CGPoint(x: 200, y: 100))
      path.addLine(to: CGPoint(x: 100, y: 300))
      path.addLine(to: CGPoint(x: 300, y: 300))
      path.addLine(to: CGPoint(x: 200, y: 100))
    }
    .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
