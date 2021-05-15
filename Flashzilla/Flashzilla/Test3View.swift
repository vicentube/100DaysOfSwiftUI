// Test3View.swift
// Flashzilla
//
// Creado el 15/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test3View: View {
  @State private var currentAmount: Angle = .degrees(0)
  @State private var finalAmount: Angle = .degrees(0)
  
  var body: some View {
    Text("Hello, World!")
      .rotationEffect(currentAmount + finalAmount)
      .gesture(
        RotationGesture()
          .onChanged { angle in
            self.currentAmount = angle
          }
          .onEnded { angle in
            self.finalAmount += self.currentAmount
            self.currentAmount = .degrees(0)
          }
      )
  }
}

struct Test3View_Previews: PreviewProvider {
  static var previews: some View {
    Test3View()
  }
}
