// SkiDetailsView.swift
// SnowSeeker
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct SkiDetailsView: View {
  let resort: Resort
  
  var body: some View {
    VStack {
      Text("Elevation: \(resort.elevation)m")
      Text("Snow: \(resort.snowDepth)cm")
    }
  }
}

struct SkiDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    SkiDetailsView(resort: Resort.example)
  }
}
