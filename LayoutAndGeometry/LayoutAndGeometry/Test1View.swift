// Test1View.swift
// LayoutAndGeometry
//
// Creado el 21/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test1View: View {
  var body: some View {
    VStack(alignment: .leading) {
      ForEach(0..<10) { position in
        Text("Number \(position)")
          .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
      }
    }
    .background(Color.red)
    .frame(width: 400, height: 400)
    .background(Color.blue)
  }
}

struct Test1View_Previews: PreviewProvider {
  static var previews: some View {
    Test1View()
  }
}
