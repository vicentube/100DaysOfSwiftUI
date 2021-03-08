// ContentView.swift
// RockPaperScissors
//
// Creado el 6/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  let moves = ["Piedra", "Papel", "Tijera"]
  
  @State private var currentChoice = Int.random(in: 0...2)
  @State private var shouldWin = Bool.random()
  @State private var score = 0
  @State private var round = 1
  @State private var showingAlert = false
  
  var body: some View {
    VStack(spacing: 40) {
      VStack {
        Text("Puntuación")
        Text("\(score)")
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      }
      VStack {
        Text("Tu oponente muestra")
        Text("\(moves[currentChoice])")
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
          .foregroundColor(.white)
          .padding()
          .background(Color.gray)
          .clipShape(Capsule())
      }
      let playerAction = shouldWin ? "ganar" : "perder"
      Text("Debes \(playerAction)")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .foregroundColor(shouldWin ? .green : .red)
      Text("¿Qué sacas?")
      HStack(spacing: 20) {
        ForEach(0..<3) { move in
          Button(moves[move]) {
            selectMove(move)
          }
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
          .foregroundColor(.white)
          .padding()
          .background(Color.blue)
          .clipShape(Capsule())
        }
      }
      Text("Intento \(round)/10")
    }
    .alert(isPresented: $showingAlert) {
      Alert(title: Text("Fin del juego"),
            message: Text("Puntuación: \(score)"),
            dismissButton: .default(Text("OK")) {
              newGame()
            })
    }
  }
  
  func selectMove(_ move: Int) {
    let win = move == ((currentChoice + 1) % 3)
    let lose = ((move + 1) % 3) == currentChoice
    let rightAnswer = (shouldWin && win) || (!shouldWin && lose)
    score = rightAnswer ? score + 1 : score - 1
    if round == 10 {
      showingAlert = true
    } else {
      newMove()
    }
  }
  
  func newMove() {
    round += 1
    currentChoice = Int.random(in: 0...2)
    shouldWin = Bool.random()
  }
  
  func newGame() {
    round = 0
    score = 0
    newMove()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
