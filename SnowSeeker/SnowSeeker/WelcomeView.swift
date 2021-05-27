// WelcomeView.swift
// SnowSeeker
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct WelcomeView: View {
  var body: some View {
    VStack {
      Text("Welcome to SnowSeeker!")
        .font(.largeTitle)
      
      Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
        .foregroundColor(.secondary)
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
