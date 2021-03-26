// ContentView.swift
// Drawing
//
// Creado el 23/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
    @State private var amount: CGFloat = 0.0

    var body: some View {
        VStack {
          Image("Example")
              .resizable()
              .scaledToFit()
              .frame(width: 200, height: 200)
              .saturation(Double(amount))
              .blur(radius: (1 - amount) * 20)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
