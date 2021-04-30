// AuthenticationService.swift
// BucketList
//
// Creado el 30/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import LocalAuthentication
import Combine

class AuthenticationService {
  static func authenticate(handler: @escaping (String?) -> Void) {
    let context = LAContext()
    var error: NSError?
    var resultError: String? = nil
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Please authenticate yourself to unlock your places."
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if !success {
            resultError = authenticationError?.localizedDescription ?? "Unknown error"
          }
          handler(resultError)
        }
      }
    } else {
      resultError = error?.localizedDescription ?? "Unknown error"
      handler(resultError)
    }
  }
}
