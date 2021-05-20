// ContentView.swift
// Flashzilla
//
// Creado el 17/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
  @Environment(\.accessibilityEnabled) var accessibilityEnabled
  @State private var cards = [Card]()
  @State private var timeRemaining = 100
  @State private var isActive = true
  @State private var showingEditScreen = false
  @State private var scaleAmount: CGFloat = 1
  @State private var feedback = UINotificationFeedbackGenerator()
  @State private var showingSettings = false
  @State private var returnCardIfWrongSetting = false
  
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack {
      Image(decorative: "background")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      VStack {
        HStack {
          Button(action: { showingSettings = true }) {
            Image(systemName: "gearshape")
              .padding()
              .background(Color.black.opacity(0.7))
              .clipShape(Circle())
          }
          .frame(minWidth: 200)
          Spacer()
          Button(action: { showingEditScreen = true }) {
            Image(systemName: "plus.circle")
              .padding()
              .background(Color.black.opacity(0.7))
              .clipShape(Circle())
          }
          .frame(minWidth: 200)
        }
        Spacer()
      }
      .foregroundColor(.white)
      .font(.largeTitle)
      .padding()
      if differentiateWithoutColor || accessibilityEnabled {
        VStack {
          Spacer()
          
          HStack {
            Button(action: {
              withAnimation {
                self.removeCard(at: self.cards.count - 1, right: false)
              }
            }) {
              Image(systemName: "xmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
            }
            .accessibility(label: Text("Wrong"))
            .accessibility(hint: Text("Mark your answer as being incorrect."))
            Spacer()
            
            Button(action: {
              withAnimation {
                self.removeCard(at: self.cards.count - 1, right: true)
              }
            }) {
              Image(systemName: "checkmark.circle")
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
            }
            .accessibility(label: Text("Correct"))
            .accessibility(hint: Text("Mark your answer as being correct."))
          }
          .foregroundColor(.white)
          .font(.largeTitle)
          .padding()
        }
      }
      VStack {
        if (timeRemaining > 0) {
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
        } else {
          Text("Time Up!")
            .font(.largeTitle)
            .foregroundColor(.red)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(
              Capsule()
                .fill(Color.white)
                .opacity(0.75)
            )
            .scaleEffect(scaleAmount)
            .animation(
              Animation.easeInOut(duration: 0.5)
                .repeatForever(autoreverses: true)
            )
        }
        ZStack {
          ForEach(0..<cards.count, id: \.self) { index in
            CardView(card: cards[index]) { right in
              withAnimation  {
                removeCard(at: index, right: right)
              }
            }
            .stacked(at: index, in: cards.count)
            .allowsHitTesting(index == cards.count - 1)
            .accessibilityHidden(index < cards.count - 1)
          }
        }
        .allowsHitTesting(timeRemaining > 0)
        if cards.isEmpty {
          Button("Start Again", action: resetCards)
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .clipShape(Capsule())
        }
      }
    }
    .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
      EditCards()
    }
    .sheet(isPresented: $showingSettings) {
      Settings(returnCard: $returnCardIfWrongSetting)
    }
    .onAppear(perform: resetCards)
    .onReceive(timer) { time in
      guard isActive else { return }
      if timeRemaining > 0 {
        timeRemaining -= 1
        feedback.prepare()
      } else {
        scaleAmount = 1.5
        feedback.notificationOccurred(.warning)
        isActive = false
      }
    }
    .onReceive(
      NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
      perform: { _ in isActive = false }
    )
    .onReceive(
      NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification),
      perform: { _ in
        if !cards.isEmpty {
          isActive = true
        }
      }
    )
  }
  
  func removeCard(at index: Int, right: Bool) {
    guard index >= 0 else { return }
    if returnCardIfWrongSetting && !right {
      let card = cards.remove(at: index)
      cards.insert(card, at: 0)
    } else {
      cards.remove(at: index)
    }
    if cards.isEmpty {
      isActive = false
    }
  }
  
  func resetCards() {
    timeRemaining = 100
    scaleAmount = 1
    isActive = true
    loadData()
  }
  
  func loadData() {
    if let data = UserDefaults.standard.data(forKey: "Cards") {
      if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
        self.cards = decoded
      }
    }
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
