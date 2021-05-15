// Test2View.swift
// Flashzilla
//
// Creado el 15/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test2View: View {
  @State private var currentAmount: CGFloat = 0
  @State private var finalAmount: CGFloat = 1
  
  var body: some View {
    Text("Hello, World!")
      .scaleEffect(finalAmount + currentAmount)
      .gesture(
        MagnificationGesture()
          .onChanged { amount in
            self.currentAmount = amount - 1
          }
          .onEnded { amount in
            self.finalAmount += self.currentAmount
            self.currentAmount = 0
          }
      )
  }
}

struct Test2View_Previews: PreviewProvider {
  static var previews: some View {
    Test2View()
  }
}
