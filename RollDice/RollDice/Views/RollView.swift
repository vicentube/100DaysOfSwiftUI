// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView<T: Model>: View {
  @ObservedObject var model: T
  
  @State private var showingSettings = false

  var body: some View {
    NavigationView {
      VStack {
        HStack {
          if let lastRoll = model.lastRoll {
            ForEach(lastRoll, id: \.self) { die in
              DieView(value: die)
            }
          }
        }
        .padding()
        .frame(maxWidth: .infinity)
        Text(model.lastRollTotal.string)
          .font(.largeTitle)
        Text("Ready to roll \(model.numOfDice) \(model.sides)-sided dice...")
          .padding()
        Button(action: model.rollDice) {
          Text("Roll Dice")
        }
      }
      .navigationBarTitle("Roll Dice")
      .toolbar { toolbar }
      .sheet(isPresented: $showingSettings) {
        SettingsView(model: model)
      }
    }
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: { showingSettings = true }) {
        Image(systemName: "gearshape")
      }
    }
  }
  
}

struct RollView_Previews: PreviewProvider {
  static var previews: some View {
    RollView(model: ModelPreview())
  }
}
