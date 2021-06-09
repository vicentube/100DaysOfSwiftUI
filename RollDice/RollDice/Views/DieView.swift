// DieView.swift
// RollDice
//
// Creado el 26/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct DieView: View {
  let value: Int
  let rolling: Bool
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20.0)
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [Color.green, Color.blue]),
            startPoint: .topLeading, endPoint: .bottomTrailing
          )
        )
        .rotation3DEffect(Angle(degrees: rolling ? 360 : 0.0),
                          axis: (x: 0.0, y: 0.0, z: 1.0))
        .animation(rollingAnimation)
      Text("\(value)")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.white)
    }
    .frame(maxWidth: 100, maxHeight: 100)
    .aspectRatio(1.0, contentMode: .fit)
    .shadow(radius: 10)
  }
  
  var rollingAnimation: Animation {
    rolling
      ? Animation.linear(duration: 0.5).repeatForever(autoreverses: false)
      : Animation.linear(duration: 0)
  }
}

struct DieView_Previews: PreviewProvider {
  static var previews: some View {
    DieView(value: 5, rolling: false)
  }
}
