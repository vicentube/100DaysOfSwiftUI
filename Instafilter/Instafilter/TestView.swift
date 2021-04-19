// TestView.swift
// Instafilter
//
// Creado el 18/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TestView: View {
  @State private var blurAmount: CGFloat = 0
  @State private var showingActionSheet = false
  @State private var backgroundColor = Color.white
  
  var body: some View {
    let blur = Binding<CGFloat>(
      get: {
        self.blurAmount
      },
      set: {
        self.blurAmount = $0
        print("New value is \(self.blurAmount)")
      })
    
    return VStack {
      Text("Hello, World!")
        .blur(radius: blurAmount)
        .frame(width: 300, height: 300)
        .background(backgroundColor)
        .onTapGesture {
          self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
          ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
            .default(Text("Red")) { self.backgroundColor = .red },
            .default(Text("Green")) { self.backgroundColor = .green },
            .default(Text("Blue")) { self.backgroundColor = .blue },
            .cancel()
          ])
        }
      
      Slider(value: blur, in: 0...20)
    }
  }
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
