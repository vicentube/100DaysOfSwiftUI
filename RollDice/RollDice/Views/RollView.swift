// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

// MARK: - ViewModel
struct RollView<T: ModelProtocol>: View {
  @ObservedObject var model: T
  
  @State private var showingSettings = false
  @State private var rotation = Angle(degrees: 0.0)
  
  private let hapticService = HapticsService()
  
  private var noDiceText: String {
    "Ready to roll \(model.numOfDice) \(model.numOfDice == 1 ? "die" : "dice") (\(model.sides)-sided)..."
  }
  
  private var animatedRotation: Angle {
    model.rolling ? rotation : .zero
  }
  
  private func showSettings() {
    showingSettings = true
  }
  
  private func onTapRollDice() {
    var count = 1
    model.rollDice() {
      hapticService?.rollDiceEffect()
      rotation = .degrees(Double((count * 20) % 360))
      count += 1
    }
  }
  
  private func resetRotation(rolling: Bool) {
    rotation = .zero
  }
  
  // MARK: - View
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
        SettingsView(model: model)
      }
    }
  }
  
  var diceView: some View {
    HStack {
      if let lastRoll = model.lastRoll {
        ForEach(lastRoll, id: \.self) { die in
          withAnimation {
            DieView(value: die)
              .rotation3DEffect(animatedRotation, axis: (x: 0.0, y: 1.0, z: 0.0))
          }
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  var totalView: some View {
    Group {
      if model.rolling {
        Text("Rolling...")
          .font(.largeTitle)
          .padding()
          .foregroundColor(.white)
          .background(Color.gray)
          .clipShape(RoundedRectangle(cornerRadius: 20))
      } else if let lastRollTotal = model.lastRollTotal {
        VStack {
          Text("Total")
            .font(.title)
          Text("\(lastRollTotal)")
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
    Button(action: onTapRollDice) {
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
      Button(action: showSettings) {
        Image(systemName: "gearshape")
      }
    }
  }
}

// MARK: - Preview
struct RollView_Previews: PreviewProvider {
  static var previews: some View {
    RollView(model: ModelPreview())
  }
}
