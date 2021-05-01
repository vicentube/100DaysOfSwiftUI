// ContentViewModel.swift
// BucketList
//
// Creado el 1/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class ContentViewModel: ObservableObject {
  @Published var showingAlert = false
  @Published var isUnlocked = false
  @Published var alertMessage = ""
  
  let authService: AuthenticationService
  
  init(authenticationService: AuthenticationService = BiometricAuthenticationService()) {
    self.authService = authenticationService
  }
  
  func authenticate() {
    authService.authenticate { [weak self] success, error in
      self?.isUnlocked = success
      if let error = error {
        self?.alertMessage = error
        self?.showingAlert = true
      }
    }
  }
}
