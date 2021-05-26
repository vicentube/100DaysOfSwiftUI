// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView<T: Model>: View {
  @ObservedObject var model: T
  
  var sides: String { "\(model.sides)" }
  var lastRoll: String { model.lastRoll.map { String($0) } ?? "" }

  var body: some View {
    VStack {
      Text(lastRoll)
        .font(.largeTitle)
      Text("Ready to roll a \(sides)-sided dice...")
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
