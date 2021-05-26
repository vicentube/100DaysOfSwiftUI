// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension RollViewModel: View {
  var body: some View {
    VStack {
      Text(lastRoll)
        .font(.largeTitle)
      Text("Ready to roll a \(sides)-sided dice...")
        .padding()
      Button(action: rollDice) {
        Text("Roll Dice")
      }
    }
  }
}

struct RollView_Previews: PreviewProvider {
  static var previews: some View {
    RollViewModel(model: AppModelFile())
  }
}
