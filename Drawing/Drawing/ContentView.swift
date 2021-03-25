// ContentView.swift
// Drawing
//
// Creado el 23/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    
    return path
  }
}

struct Arc: Shape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool
  
  func path(in rect: CGRect) -> Path {
    let rotationAdjustment = Angle.degrees(90)
    let modifiedStart = startAngle - rotationAdjustment
    let modifiedEnd = endAngle - rotationAdjustment
    var path = Path()
    path.addArc(
      center: CGPoint(x: rect.midX, y: rect.midY),
      radius: rect.width / 2,
      startAngle: modifiedStart,
      endAngle: modifiedEnd,
      clockwise: !clockwise)
    
    return path
  }
}

struct ContentView: View {
  var body: some View {
    VStack {
      Triangle()
        .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        .frame(width: 300, height: 300)
      Arc(startAngle: .degrees(0), endAngle: .degrees(45), clockwise: true)
        .stroke(Color.blue, lineWidth: 10)
        .frame(width: 300,  height: 300)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
