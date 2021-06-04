// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RollView: View {
  @ObservedObject var appState = RollDiceApp.controller.appState
  @StateObject private var viewState = RollView.State()
  private let interactor = RollDiceApp.controller.rollViewInteractor
  
  var body: some View {
    NavigationView {
      VStack {
        Text(diceInfoText)
        diceView
        Spacer()
        totalView
        Spacer()
        rollButton
      }
      .padding()
      .navigationBarTitle("Roll Dice")
      .toolbar { toolbar }
      .sheet(isPresented: $viewState.showingSettings, onDismiss: onDismissSettings) {
        SettingsView()
      }
    }
  }
  
  var diceInfoText: String {
    let dieOrDice = appState.numOfDice == 1 ? "die" : "dice"
    return "Rolling \(appState.numOfDice) \(dieOrDice) (\(appState.sides)-sided)..."
  }
  
  var rollingAnimation: Animation {
    viewState.rolling
      ? Animation.linear(duration: 0.5).repeatForever(autoreverses: false)
      : Animation.linear(duration: 0)
  }
  
  var diceView: some View {
    HStack {
      ForEach(appState.diceValues.indices, id: \.self) { index in
        DieView(value: appState.diceValues[index], show: viewState.showingDice)
          .rotation3DEffect(Angle(degrees: viewState.rolling ? 360 : 0.0),
                            axis: (x: 0.0, y: 0.0, z: 1.0))
          .animation(rollingAnimation)
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
      } else if viewState.showingDice {
        VStack {
          Text("Total")
            .font(.title)
          Text("\(appState.totalValue)")
        }
        .font(.largeTitle)
        .foregroundColor(.white)
        .frame(width: 150, height: 150)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 20))
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
  
  func onDismissSettings() {
    viewState.showingDice = false
  }
  
  func onRollButtonTap() {
    interactor.rollDice(viewState)
  }
}

struct RollView_Previews: PreviewProvider {
  static var previews: some View {
    RollDiceApp.controller = RollDiceApp.preview
    return RollView()
  }
}
