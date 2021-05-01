// AuthenticationService.swift
// BucketList
//
// Creado el 30/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import LocalAuthentication
import Combine

protocol AuthenticationService {
  func authenticate(completion: @escaping (Bool, String?) -> Void) -> Void
}

final class BiometricAuthenticationService: AuthenticationService {
  func authenticate(completion: @escaping (Bool, String?) -> Void) {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Please authenticate yourself to unlock your places."
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if success {
            completion(true, nil)
          } else {
            completion(false, authenticationError?.localizedDescription ?? "Unknown error")
          }
        }
      }
    } else {
      completion(false, error?.localizedDescription ?? "Unknown error")
    }
  }
}
