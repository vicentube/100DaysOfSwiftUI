// ContentView.swift
// Drawing
//
// Creado el 23/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
        Image("Example")
          .colorMultiply(.red)

//        Rectangle()
//            .fill(Color.red)
//            .blendMode(.multiply)
    }
    .frame(width: 400, height: 500)
    .clipped()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
