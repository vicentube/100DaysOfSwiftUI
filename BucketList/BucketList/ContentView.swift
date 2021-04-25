// ContentView.swift
// BucketList
//
// Creado el 24/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import LocalAuthentication

struct ContentView: View {
  @State private var isUnlocked = false
  
  var body: some View {
    VStack {
      if isUnlocked {
        Text("Unlocked")
      } else {
        Text("Locked")
      }
    }
    .onAppear(perform: authenticate)
  }
  
  func authenticate() {
    let context = LAContext()
    var error: NSError?
    
    // check whether biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      // it's possible, so go ahead and use it
      let reason = "We need to unlock your data."
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        // authentication has now completed
        DispatchQueue.main.async {
          if success {
            isUnlocked = true
          } else {
            // there was a problem
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
