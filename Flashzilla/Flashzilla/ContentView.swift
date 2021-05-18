// ContentView.swift
// Flashzilla
//
// Creado el 17/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
  @State private var cards = [Card](repeating: Card.example, count: 10)
  @State private var timeRemaining = 100
  @State private var isActive = true
  
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      VStack {
        if differentiateWithoutColor {
          VStack {
            Spacer()
            
            HStack {
              Image(systemName: "xmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
              Spacer()
              Image(systemName: "checkmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
          }
        }
        Text("Time: \(timeRemaining)")
          .font(.largeTitle)
          .foregroundColor(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 5)
          .background(
            Capsule()
              .fill(Color.black)
              .opacity(0.75)
          )
        ZStack {
          ForEach(0..<cards.count, id: \.self) { index in
            CardView(card: cards[index]) {
              withAnimation  {
                removeCard(at: index)
              }
            }
            .stacked(at: index, in: cards.count)
          }
        }
      }
    }
    .onReceive(timer) { time in
      guard isActive else { return }
      if timeRemaining > 0 {
        timeRemaining -= 1
      }
    }
    .onReceive(
      NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
      perform: { _ in isActive = false }
    )
    .onReceive(
      NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification),
      perform: { _ in isActive = true }
    )
  }
  
  func removeCard(at index: Int) {
    cards.remove(at: index)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension View {
  func stacked(at position: Int, in total: Int) -> some View {
    let offset = CGFloat(total - position)
    return self.offset(CGSize(width: 0, height: offset * 10))
  }
}
