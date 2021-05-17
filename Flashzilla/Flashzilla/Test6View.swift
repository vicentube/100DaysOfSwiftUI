// Test6View.swift
// Flashzilla
//
// Creado el 16/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test6View: View {
  var body: some View {
    Text("Hello, World!")
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
        print("Moving to the background!")
      }
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
        print("Moving back to the foreground!")
      }
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
        print("User took a screenshot!")
      }
  }
}

struct Test6View_Previews: PreviewProvider {
  static var previews: some View {
    Test6View()
  }
}
