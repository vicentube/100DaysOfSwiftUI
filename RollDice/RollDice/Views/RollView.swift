// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView: View {
  @EnvironmentObject var appState: AppState
  @Environment(\.rollInteractor) var interactor: RollInteractorProtocol
  
  @State private var rolling = false
  @State private var totalValue: Int?
  @State private var showingSettings = false
  @State private var diceValues: [Int]? = nil
  
  private var noDiceText: String {
    let dieOrDice = appState.numOfDice == 1 ? "die" : "dice"
    return "Ready to roll \(appState.numOfDice) \(dieOrDice) (\(appState.sides)-sided)..."
  }
  
  var foreverAnimation: Animation {
    Animation.linear(duration: 0.5)
      .repeatForever(autoreverses: false)
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
        SettingsView().environmentObject(appState)
      }
    }
  }
  
  var diceView: some View {
    HStack {
      if let diceValues = diceValues {
        ForEach(diceValues.indices, id: \.self) { index in
          DieView(value: diceValues[index])
            .rotation3DEffect(Angle(degrees: rolling ? 360 : 0.0),
                              axis: (x: 0.0, y: 1.0, z: 0.0))
            .animation(rolling ? foreverAnimation : .default)
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
      } else if let totalValue = totalValue {
        VStack {
          Text("Total")
            .font(.title)
          Text("\(totalValue)")
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
    Button(action: onRollDiceTap) {
      Text("Roll Dice")
    }
    .padding()
    .font(.title)
    .foregroundColor(.white)
    .background(Color.accentColor)
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .padding(.bottom)
    .disabled(rolling)
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: { showingSettings = true }) {
        Image(systemName: "gearshape")
      }
    }
  }
  
  func onRollDiceTap() {
    interactor.rollDice(diceValues: $diceValues,
                        totalValue: $totalValue,
                        rolling: $rolling)
  }
}

struct RollView_Previews: PreviewProvider {
  static var previews: some View {
    RollView().environmentObject(AppState())
  }
}
