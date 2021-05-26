// Day96_3.swift
// SnowSeeker
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Day96_3: View {
  @Environment(\.horizontalSizeClass) var sizeClass
  
  var body: some View {
    Group {
      if sizeClass == .compact {
        VStack(content: UserView.init)
      } else {
        HStack(content: UserView.init)
      }
    }
  }
}

struct Day96_3_Previews: PreviewProvider {
  static var previews: some View {
    Day96_3()
  }
}

struct UserView: View {
  var body: some View {
    Group {
      Text("Name: Paul")
      Text("Country: England")
      Text("Pets: Luna, Arya, and Toby")
    }
  }
}
