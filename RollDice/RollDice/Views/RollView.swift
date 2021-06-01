// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView: View {
  @EnvironmentObject var appState: AppState
  @Environment(\.interactors) var interactors: InteractorsContainer
  
  @State private var rolling = false
  @State private var showingSettings = false
  @State private var rotation = Angle(degrees: 0.0)
  @State private var diceValues: [Int]? = nil
  
  private var noDiceText: String {
    "Ready to roll \(appState.settings.numOfDice) \(appState.settings.numOfDice == 1 ? "die" : "dice") (\(appState.settings.sides)-sided)..."
  }
  
  private var animatedRotation: Angle {
    rolling ? rotation : .zero
  }
  
  var body: some View {
    NavigationView {
      VStack {
        diceView
        Spacer()
        totalView
        Spacer()
        rollButton
      }
      .padding()
      .navigationBarTitle("Roll Dice")
      .toolbar { toolbar }
      .sheet(isPresented: $showingSettings) {
        SettingsView()
      }
    }
  }
  
  var diceView: some View {
    HStack {
      if let diceValues = diceValues {
        ForEach(diceValues.indices, id: \.self) { index in
          withAnimation {
            DieView(value: diceValues[index])
              .rotation3DEffect(animatedRotation, axis: (x: 0.0, y: 1.0, z: 0.0))
          }
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  var totalView: some View {
    Group {
      if rolling {
        Text("Rolling...")
          .font(.largeTitle)
          .padding()
          .foregroundColor(.white)
          .background(Color.gray)
          .clipShape(RoundedRectangle(cornerRadius: 20))
      } else if let diceValues = diceValues {
        VStack {
          Text("Total")
            .font(.title)
          Text("\(diceValues.reduce(0, +))")
        }
        .font(.largeTitle)
        .foregroundColor(.white)
        .frame(width: 150, height: 150)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      } else {
        Text(noDiceText)
          .padding()
      }
    }
  }
  
  var rollButton: some View {
    Button(action: { interactors.rollView.rollDice(diceValues: $diceValues, rolling: $rolling) }) {
      Text("Roll Dice")
    }
    .padding()
    .font(.title)
    .foregroundColor(.white)
    .background(Color.accentColor)
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .padding(.bottom)
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
    RollView()
  }
}
