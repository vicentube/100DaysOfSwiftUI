// HapticsService.swift
// RollDice
//
// Creado el 28/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import UIKit

final class HapticsService {
  private let generator = UINotificationFeedbackGenerator()
  
  func prepare() {
    generator.prepare()
  }
  
  func rollingEffect() {
    generator.notificationOccurred(.success)
  }
}
