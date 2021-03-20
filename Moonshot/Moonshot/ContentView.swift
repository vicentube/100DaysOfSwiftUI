// ContentView.swift
// Moonshot
//
// Creado el 20/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      GeometryReader { geo in
        Image("AppleM1")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: geo.size.width)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
