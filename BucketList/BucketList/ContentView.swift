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
  @State private var isUnlocked = false
  
  var body: some View {
    ZStack {
      if isUnlocked {
        UnlockedView()
      } else {
        Button("Unlock Places") {
          self.authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
      }
    }
  }
  
  func authenticate() {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Please authenticate yourself to unlock your places."
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if success {
            isUnlocked = true
          } else {
            // error
          }
        }
      }
    } else {
      // no biometrics
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
