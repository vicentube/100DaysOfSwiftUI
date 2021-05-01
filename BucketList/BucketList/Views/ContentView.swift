// ContentView.swift
// BucketList
//
// Creado el 24/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
  @ObservedObject var model: Model
  @State private var showingAlert = false
  @State private var alertTitle = Text("")
  @State private var alertMessage = Text("")
  
  var body: some View {
    ZStack {
      if model.isUnlocked {
        UnlockedView(model: model)
      } else {
        Button(action: authenticate) {
          Text("Unlock Places")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .alert(isPresented: $showingAlert) {
          Alert(title: alertTitle, message: alertMessage, dismissButton: .default(Text("OK")))
        }
      }
    }
    
  }
  
  func authenticate() {
    model.authenticate { error in
      if let error = error {
        alertTitle = Text("Error")
        alertMessage = Text(error)
        showingAlert = true
      }
      else {
        model.isUnlocked = true
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(model: Model())
  }
}
