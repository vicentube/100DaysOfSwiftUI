// Day96_1.swift
// SnowSeeker
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Day96_1: View {
  var body: some View {
    NavigationView {
      NavigationLink(destination: Text("New secondary")) {
        Text("Hello, World!")
      }
      .navigationBarTitle("Primary")
      
      Text("Secondary")
    }
  }
}

struct Day96_1_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
