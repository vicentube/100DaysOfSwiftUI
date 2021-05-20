// Settings.swift
// Flashzilla
//
// Creado el 20/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Settings: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var returnCard: Bool
  
  var body: some View {
    NavigationView {
      Form {
        Toggle(isOn: $returnCard) {
          Text("Return card to the stack if wrong")
        }
      }
      .navigationBarTitle("Settings")
      .navigationBarItems(trailing: Button("Done", action: dismiss))
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
  
  func dismiss() {
    presentationMode.wrappedValue.dismiss()
  }
}

struct Settings_Previews: PreviewProvider {
  static var previews: some View {
    Settings(returnCard: .constant(true))
  }
}
