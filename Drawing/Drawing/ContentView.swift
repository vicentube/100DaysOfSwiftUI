// ContentView.swift
// Drawing
//
// Creado el 23/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Arrow: Shape {
  let head: CGFloat = 0.618034
  var tail: CGFloat = 0.25
  
  var animatableData: CGFloat {
    get { return tail }
    set { self.tail = newValue }
  }
  
  func path(in rect: CGRect) -> Path {
    let headY = rect.height * (1 - head)
    
    var trianglePath = Path()
    
    trianglePath.move(to: CGPoint(x: rect.minX, y: headY))
    trianglePath.addLine(to: CGPoint(x: rect.maxX, y: headY))
    trianglePath.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    trianglePath.addLine(to: CGPoint(x: rect.minX, y: headY))
    
    var path = Path()
    path.addRect(
      CGRect(
        x: rect.midX - (tail * rect.width / 2),
        y: headY,
        width: rect.width * tail,
        height: rect.height * head))
    path.addPath(trianglePath)
    
    return path
  }
}

struct ColorCyclingRectangle: View {
  var amount = 0.0
  var steps = 100
  
  var body: some View {
    ZStack {
      ForEach(0..<steps) { value in
        Rectangle()
          .inset(by: CGFloat(value))
          .strokeBorder(LinearGradient(gradient: Gradient(colors: [
            self.color(for: value, brightness: 1),
            self.color(for: value, brightness: 0.5)
          ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
      }
    }
    .drawingGroup()
  }
  
  func color(for value: Int, brightness: Double) -> Color {
    var targetHue = Double(value) / Double(self.steps) + self.amount
    
    if targetHue > 1 {
      targetHue -= 1
    }
    
    return Color(hue: targetHue, saturation: 1, brightness: brightness)
  }
}

struct ContentView: View {
  @State private var amount: CGFloat = 0.25
  @State private var colorCycle = 0.0
  
  var body: some View {
    VStack(spacing: 40) {
      Button(action: onTapButton) {
        Text("Animate it!")
          .font(.largeTitle)
      }
      Arrow(tail: amount)
        .stroke(Color.blue,
                style: StrokeStyle(lineWidth: (50 * amount) + 5, lineCap: .round, lineJoin: .round))
        .frame(width: 200)
      ColorCyclingRectangle(amount: colorCycle)
        .frame(width: 300, height: 300)
      Slider(value: $colorCycle)
    }
  }
  
  func onTapButton() {
    withAnimation {
      amount = CGFloat.random(in: 0...1)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
