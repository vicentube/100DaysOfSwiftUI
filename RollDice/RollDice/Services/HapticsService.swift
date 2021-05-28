// HapticsService.swift
// RollDice
//
// Creado el 28/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreHaptics

final class HapticsService {
  private var engine: CHHapticEngine? = nil
  
  init?() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return nil }
    
    do {
      self.engine = try CHHapticEngine()
      try engine?.start()
    } catch {
      print("There was an error creating the engine: \(error.localizedDescription)")
    }
  }
  
  func rollDiceEffect() {
    var events = [CHHapticEvent]()
    
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
    events.append(event)
    
    do {
      let pattern = try CHHapticPattern(events: events, parameters: [])
      let player = try engine?.makePlayer(with: pattern)
      try player?.start(atTime: 0)
    } catch {
      print("Failed to play pattern: \(error.localizedDescription)")
    }
  }
}
