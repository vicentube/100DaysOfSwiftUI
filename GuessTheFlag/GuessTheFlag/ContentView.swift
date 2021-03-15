// ContentView.swift
// GuessTheFlag
//
// Creado el 1/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct FlagImage: View {
  var country: String
  var isCorrect: Bool
  var animated: Bool
  
  var body: some View {
    let opacity = animated && !isCorrect ? 0.25 : 1.0
    let degrees = animated && isCorrect ? 360.0 : 0.0
    Image(country)
      .renderingMode(.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color: .black, radius: 2)
      .opacity(opacity)
      .rotation3DEffect(.degrees(degrees), axis: (x:0, y: 1, z: 0))
  }
}

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany",
                                  "Ireland", "Italy", "Nigeria",
                                  "Poland", "Russia", "Spain",
                                  "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var userScore = 0
  @State private var animateFlags = false
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .black,]),
                     startPoint: .top,
                     endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .foregroundColor(.white)
          Text(countries[correctAnswer])
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.black)
        }
        ForEach(0 ..< 3) { number in
          Button(action: {
            self.flagTapped(number)
          }) {
            let correct = number == correctAnswer
            FlagImage(
              country: countries[number],
              isCorrect: correct,
              animated: animateFlags)
          }
        }
        Spacer()
        VStack {
          Text("Your current score is")
            .foregroundColor(.white)
          Text("\(userScore)")
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        Spacer()
      }
    }
    .alert(isPresented: $showingScore) {
      Alert(title: Text(scoreTitle),
            message: Text("Your score is \(userScore)"),
            dismissButton: .default(Text("Continue")) {
              self.askQuestion()
            })
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      userScore += 1
      withAnimation {
        animateFlags = true
      }
    } else {
      scoreTitle = "Wrong! That's the flag of \(countries[number])"
      userScore -= 1
    }
    showingScore = true
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    animateFlags = false
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
