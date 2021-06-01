// DIContainer.swift
// RollDice
//
// Creado el 1/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import Combine

// MARK: - DIContainer
struct DIContainer: EnvironmentKey {
  
  let appState: AppState
  let interactors: InteractorsContainer
  
  init(appState: AppState, interactors: InteractorsContainer) {
    self.appState = appState
    self.interactors = interactors
  }
  
  static var defaultValue: Self { Self.default }
  
  private static let `default` = Self(appState: AppState(), interactors: .stub)
}

extension EnvironmentValues {
  var injected: DIContainer {
    get { self[DIContainer.self] }
    set { self[DIContainer.self] = newValue }
  }
}

//#if DEBUG
//extension DIContainer {
//  static var preview: Self {
//    .init(appState: .init(AppState.preview), interactors: .stub)
//  }
//}
//#endif

// MARK: - Injection in the view hierarchy
extension View {
  
  func inject(_ appState: AppState,
              _ interactors: InteractorsContainer) -> some View {
    let container = DIContainer(appState: appState,
                                interactors: interactors)
    return inject(container)
  }
  
  func inject(_ container: DIContainer) -> some View {
    return self
      .environment(\.injected, container)
  }
}
