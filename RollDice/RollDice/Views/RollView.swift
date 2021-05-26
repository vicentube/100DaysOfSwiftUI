// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView<T: Model>: View {
  @ObservedObject var model: T

  var body: some View {
    VStack {
      Text(model.lastRoll.string)
        .font(.largeTitle)
      Text("Ready to roll a \(model.sides)-sided dice...")
        .padding()
      Button(action: model.rollDice) {
        Text("Roll Dice")
      }
    }
  }
}

struct RollView_Previews: PreviewProvider {
  static var previews: some View {
    RollView(model: ModelPreview())
  }
}
