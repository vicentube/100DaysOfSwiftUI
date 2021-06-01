// SettingsView.swift
// RollDice
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var appState: AppState
  @Environment(\.interactors) var interactors: InteractorsContainer
  @Environment(\.presentationMode) var presentationMode
  
  let possibleSides: [Int] = [4, 6, 8, 10, 12, 20, 100]
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Number of sides")) {
          Picker("Number of sides", selection: $appState.settings.sides) {
            ForEach(possibleSides, id: \.self) { sides in
              Text("\(sides)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Number of dice")) {
          Picker("Number of dice", selection: $appState.settings.numOfDice) {
            ForEach(1..<5, id: \.self) { num in
              Text("\(num)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar { toolbar }
    }
  }
  
  var toolbar: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Button(action: { interactors.settings.saveSettings(presentationMode: presentationMode) }) {
        Text("Done")
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
