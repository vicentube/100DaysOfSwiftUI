// SettingsView.swift
// RollDice
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct SettingsView: View {
  @StateObject private var vm = SettingsViewModel()
  let onDone: (Settings) -> Void
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Number of sides")) {
          Picker("Number of sides", selection: $vm.settings.sides) {
            ForEach(vm.possibleSides, id: \.self) { sides in
              Text("\(sides)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Number of dice")) {
          Picker("Number of dice", selection: $vm.settings.numOfDice) {
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
      Button(action: { onDone(vm.settings) }) {
        Text("Done")
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    AppModel.shared = AppModel.preview
    return SettingsView() { _ in }
  }
}
