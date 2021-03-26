// ContentView.swift
// Drawing
//
// Creado el 23/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Arrow: Shape {
  let head: CGFloat = 0.618034
  let tail: CGFloat = 0.2
  
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

struct ContentView: View {
  
  var body: some View {
    Arrow()
  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
