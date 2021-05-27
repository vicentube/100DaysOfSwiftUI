// RollView.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension RollView: View {
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
          DieView(value: die)
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  var totalView: some View {
    Group {
      if let lastRollTotal = model.lastRollTotal {
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
    Button(action: model.rollDice) {
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

struct RollView_Previews: PreviewProvider {
  static var previews: some View {
    RollView(model: ModelPreview())
  }
}
