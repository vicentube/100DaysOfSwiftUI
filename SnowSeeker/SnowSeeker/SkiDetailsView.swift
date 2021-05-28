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
    Group {
      Text("Elevation: \(resort.elevation)m").layoutPriority(1)
      Spacer().frame(height: 0)
      Text("Snow: \(resort.snowDepth)cm").layoutPriority(1)
    }
  }
}

struct SkiDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    SkiDetailsView(resort: Resort.example)
  }
}
