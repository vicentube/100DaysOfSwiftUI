// Test5View.swift
// HotProspects
//
// Creado el 9/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test5View: View {
  var body: some View {
    Image("example")
      .interpolation(.none)    
      .resizable()
      .scaledToFit()
      .frame(maxHeight: .infinity)
      .background(Color.black)
      .edgesIgnoringSafeArea(.all)
  }
}

struct Test5View_Previews: PreviewProvider {
  static var previews: some View {
    Test5View()
  }
}
