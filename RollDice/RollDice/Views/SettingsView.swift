// SettingsView.swift
// RollDice
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct SettingsView<T: ModelProtocol>: View {
  // MARK: - ViewModel
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var model: T
  
  func saveSettings() {
    model.saveSettings()
    presentationMode.wrappedValue.dismiss()
  }
  
  // MARK: - View
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Number of sides")) {
          Picker("Number of sides", selection: $model.sides) {
            ForEach(model.possibleSides, id: \.self) { sides in
              Text("\(sides)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Number of dice")) {
          Picker("Number of dice", selection: $model.numOfDice) {
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
      Button(action: saveSettings) {
        Text("Done")
      }
    }
  }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(model: ModelPreview())
  }
}
