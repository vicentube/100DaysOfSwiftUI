// SettingsView.swift
// MultiplicationTables
//
// Creado el 16/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct SettingsView: View {
  @Binding var game: Game
  @State private var showingAlert = false
  @State private var alertMessage = ""
  
  var body: some View {
    NavigationView {
      VStack(spacing: 30) {
        VStack {
          Text("¿Qué tablas deseas practicar?")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
          HStack(spacing: 20) {
            ForEach(1..<6) { column in
              VStack(spacing: 20) {
                ForEach(0..<2) { row in
                  let table = column + (5 * row)
                  Button(action: { toggleTable(table) } ) {
                    Text("\(table)")
                      .font(.title)
                      .fontWeight(.bold)
                      .foregroundColor(.white)
                  }
                  .frame(width: 50, height: 50)
                  .background(
                    RoundedRectangle(cornerRadius: 5)
                      .fill(game.tables.contains(table) ? Color.green : Color.gray))
                  .shadow(color: Color.black, radius: 2, y: 2)
                }
              }
            }
          }
        }
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(
              LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)))
        VStack {
          Text("¿Cuántas preguntas quieres?")
            .font(.headline)
            .foregroundColor(.white)
          Picker("Número de preguntas", selection: $game.numberOfQuestions) {
            Text("5").tag(5)
            Text("10").tag(10)
            if game.tables.count > 1 {
              Text("20").tag(20)
            }
            Text("Todas").tag(game.tables.count*10)
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(
              LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)))
        Button(action: startGame) {
          Text("Empezar")
            .foregroundColor(.white)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 10)
                .fill(
                  LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                                 startPoint: .topLeading,
                                 endPoint: .bottomTrailing)))
        }
        .padding()
        .shadow(color: Color.black, radius: 2, y: 2)
        Spacer()
        
      }
      .padding()
      .navigationBarTitle("Ajustes 🦊")
      .alert(isPresented: $showingAlert) {
        Alert(
          title: Text("🤷‍♂️"),
          message: Text("\(alertMessage)"),
          dismissButton: .default(Text("OK")))
      }
    }
  }
  
  func toggleTable(_ table: Int) {
    if game.tables.contains(table) {
      game.tables.remove(table)
    } else {
      game.tables.insert(table)
    }
  }
  
  func startGame() {
    guard !game.tables.isEmpty else {
      alertMessage = "Selecciona al menos una tabla"
      showingAlert = true
      return
    }
    game.fillQuestions()
    withAnimation {
      game.gameActive = true
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(game: .constant(Game()))
  }
}
