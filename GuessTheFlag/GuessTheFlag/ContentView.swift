// ContentView.swift
// GuessTheFlag
//
// Creado el 1/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct FlagImage: View {
  var country: String
  
  var body: some View {
    Image(country)
      .renderingMode(.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color: .black, radius: 2)
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
  @State private var correctSelected = false
  @State private var wrongSelected: Int? = nil
  
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
            let opacity = correctSelected && !correct ? 0.25 : 1.0
            let rotationY = correctSelected && correct ? 360.0 : 0.0
            let rotationZ = number == (wrongSelected ?? -1) ? 90.0 : 0.0
            FlagImage(country: countries[number])
              .opacity(opacity)
              .rotation3DEffect(.degrees(rotationY), axis: (x:0, y: 1, z:0))
              .rotationEffect(.degrees(rotationZ), anchor: .leading)
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
        correctSelected = true
      }
    } else {
      scoreTitle = "Wrong! That's the flag of \(countries[number])"
      userScore -= 1
      withAnimation(.interpolatingSpring(stiffness: 30, damping: 1)) {
        wrongSelected = number
      }
    }
    showingScore = true
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    withAnimation(.easeIn(duration: 0.0)) {
      correctSelected = false
      wrongSelected = nil
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
