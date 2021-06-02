// RollDiceApp.swift
// RollDice
//
// Creado el 24/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct RollDiceApp: App {
  @StateObject private var appState: AppState
  
  private(set) var loadingInteractor: LoadingInteractorProtocol
  private(set) var rollInteractor: RollInteractorProtocol
  private(set) var historyInteractor: HistoryInteractorProtocol
  
  init() {
    let state = AppState()
    let persistence = CoreDataPersistence()
    _appState = StateObject(wrappedValue: state)
    loadingInteractor = LoadingInteractor(appState: state, persistence: persistence)
    rollInteractor = RollInteractor(appState: state, persistence: persistence)
    historyInteractor = HistoryInteractor(appState: state, persistence: persistence)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appState)
        .environment(\.loadingInteractor, loadingInteractor)
        .environment(\.rollInteractor, rollInteractor)
        .environment(\.historyInteractor, historyInteractor)
    }
  }
}
