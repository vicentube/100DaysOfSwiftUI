// DieView.swift
// RollDice
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct DieView: View {
  // MARK: - ViewModel
  let value: Int
  
  
  // MARK: - View
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20.0)
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [Color.green, Color.blue]),
            startPoint: .topLeading, endPoint: .bottomTrailing
          )
        )
      Text("\(value)")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.white)
    }
    .frame(maxWidth: 100, maxHeight: 100)
    .aspectRatio(1.0, contentMode: .fit)
    .shadow(radius: 10)
  }
}

// MARK: - Preview
struct DieView_Previews: PreviewProvider {
  static var previews: some View {
    DieView(value: 5)
  }
}
