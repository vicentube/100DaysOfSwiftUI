// GameView.swift
// MultiplicationTables
//
// Creado el 16/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct GameView: View {
  @Binding var game: Game
  @State private var currentQuestion = 1
  @State private var answerText = ""
  @State private var currentResult: Bool? = nil
  @State private var score = 0
  @State private var gameOver = false
  
  var f1: Int {
    game.questions.first?.f1 ?? 0
  }
  
  var f2: Int {
    game.questions.first?.f2 ?? 0
  }
  
  var mult: Int {
    f1 * f2
  }
  
  var body: some View {
    VStack {
      Text("🐘").font(Font.system(size: 50))
      VStack {
        Text("Pregunta \(currentQuestion)/\(game.numberOfQuestions)")
          .font(.title)
          .foregroundColor(.white)
          .padding()
        Text("\(f1) x \(f2)")
          .font(.title)
          .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          .foregroundColor(.white)
        Divider()
        TextField("?", text: $answerText)
          .font(Font.system(size: 40, design: .rounded))
          .multilineTextAlignment(.center)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .keyboardType(.numberPad)
          .frame(width: 80, height: 80)
      }
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(
            LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)))
      
      if let currentResult = currentResult {
        Text(currentResult ? "🤩" : "😩")
          .font(.largeTitle)
        Text(currentResult ? "¡Bien hecho!" : "¡Mal! La respuesta correcta es \(mult)")
        if gameOver {
          VStack {
            Text("Has acertado \(score) de \(game.numberOfQuestions)")
              .padding()
            HStack(spacing: 40) {
              Button(action: { game.gameActive = false }) {
                Text("Ajustes")
              }
              .padding()
              .foregroundColor(.white)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .fill(
                    LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)))
              .shadow(color: Color.black, radius: 2, y: 2)
              Button(action: playAgain) {
                Text("Intentar de nuevo")
              }
              .padding()
              .foregroundColor(.white)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .fill(
                    LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)))
              .shadow(color: Color.black, radius: 2, y: 2)
            }
          }
        } else {
          Button(action: nextQuestion) {
            Text("Siguiente")
          }
          .padding()
          .foregroundColor(.white)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(
                LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)))
          .shadow(color: Color.black, radius: 2, y: 2)
        }
      } else {
        Button(action: checkAnswer)
        {
          Text("Comprobar")
            .foregroundColor(.white)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 10)
                .fill(
                  LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                                 startPoint: .topLeading,
                                 endPoint: .bottomTrailing)))
            .shadow(color: Color.black, radius: 2, y: 2)
        }
      }
      Spacer()
    }
    .padding()
  }
  
  func checkAnswer() {
    guard let number = Int(answerText) else { return }
    if number == mult {
      score += 1
      currentResult = true
    } else {
      currentResult = false
    }
    if game.questions.count == 1 {
      gameOver = true
    }
  }
  
  func nextQuestion() {
    currentQuestion += 1
    answerText = ""
    currentResult = nil
    game.questions.removeFirst()
  }
  
  func playAgain() {
    currentQuestion = 1
    currentResult = nil
    answerText = ""
    score = 0
    gameOver = false
    game.fillQuestions()
  }
}

struct GameView_Previews: PreviewProvider {
  static var game = Game()
  static var previews: some View {
    GameView(game: .constant(game))
  }
}
