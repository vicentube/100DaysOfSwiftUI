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
      Text("Size: \(size)").layoutPriority(1)
      Spacer().frame(height: 0)
      Text("Price: \(price)").layoutPriority(1)
    }
  }
  
  var size: String {
    switch resort.size {
    case 1:
      return "Small"
    case 2:
      return "Average"
    default:
      return "Large"
    }
  }
  
  var price: String {
    String(repeating: "$", count: resort.price)
  }
}

struct ResortDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    ResortDetailsView(resort: Resort.example)
  }
}
