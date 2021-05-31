// ResortDetailsView.swift
// SnowSeeker
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ResortDetailsView: View {
  let resort: Resort
  
  var body: some View {
    Group {
      Text("Size: \(resort.sizeText)").layoutPriority(1)
      Spacer().frame(height: 0)
      Text("Price: \(resort.priceText)").layoutPriority(1)
    }
  }
}

struct ResortDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    ResortDetailsView(resort: Resort.example)
  }
}
