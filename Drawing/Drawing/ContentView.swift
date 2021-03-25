// ContentView.swift
// Drawing
//
// Creado el 23/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  var body: some View {
    Capsule()
      .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
      .frame(width: 300, height: 200)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
