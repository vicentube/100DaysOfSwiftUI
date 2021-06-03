// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView: View {
  @EnvironmentObject var appState: AppState
  @StateObject private var viewState = RollView.State()
  private let interactor = RollDiceApp.controller.rollViewInteractor
  
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
      .sheet(isPresented: $viewState.showingSettings) {
        SettingsView()
      }
    }
  }
  
  var noDiceText: String {
    let dieOrDice = appState.numOfDice == 1 ? "die" : "dice"
    return "Ready to roll \(appState.numOfDice) \(dieOrDice) (\(appState.sides)-sided)..."
  }
  
  var foreverAnimation: Animation {
    Animation.linear(duration: 0.5)
      .repeatForever(autoreverses: false)
  }
  
  var diceView: some View {
    HStack {
      if let diceValues = viewState.diceValues {
        ForEach(diceValues.indices, id: \.self) { index in
          DieView(value: diceValues[index])
            .rotation3DEffect(Angle(degrees: viewState.rolling ? 360 : 0.0),
                              axis: (x: 0.0, y: 1.0, z: 0.0))
            .animation(viewState.rolling ? foreverAnimation : .default)
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  var totalView: some View {
    Group {
      if viewState.rolling {
        Text("Rolling...")
          .font(.largeTitle)
          .padding()
          .foregroundColor(.white)
          .background(Color.gray)
          .clipShape(RoundedRectangle(cornerRadius: 20))
      } else if let totalValue = viewState.totalValue {
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
    Button(action: onRollButtonTap) {
      Text("Roll Dice")
    }
    .padding()
    .font(.title)
    .foregroundColor(.white)
    .background(Color.accentColor)
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .padding(.bottom)
    .disabled(viewState.rolling)
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: { viewState.showingSettings = true }) {
        Image(systemName: "gearshape")
      }
    }
  }
  
  func onRollButtonTap() {
    interactor.rollDice(viewState)
  }
}

struct RollView_Previews: PreviewProvider {
  static var previews: some View {
    RollDiceApp.controller = RollDiceApp.preview
    let appState = RollDiceApp.controller.appState
    return RollView().environmentObject(appState)
  }
}
