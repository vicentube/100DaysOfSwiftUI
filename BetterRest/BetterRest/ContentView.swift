// ContentView.swift
// BetterRest
//
// Creado el 8/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreML

struct ContentView: View {
  @State private var wakeUp = Date()
  @State private var sleepAmount = 8.0
  @State private var cupsSelectedIndex = 0
  @State private var resultHeader = ""
  @State private var resultMessage = ""
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  
  var coffeeAmount: Int { cupsSelectedIndex + 1 }
  
  var body: some View {
    NavigationView {
      VStack {
        let result = calculateBedtime()
        Text(result.header)
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
          .padding(.top)
        Text(result.message)
          .font(.largeTitle)
          .fontWeight(.bold)
        Form {
          Section(header: Text("When do you want to wake up?")) {
            DatePicker("Please enter a time",
                       selection: $wakeUp,
                       displayedComponents: .hourAndMinute)
          }
          Section(header: Text("Desired amount of sleep")) {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
              Text("\(sleepAmount, specifier: "%g") hours")
            }
          }
          Section(header: Text("Daily coffee intake")) {
            Picker("Nummber of cups", selection: $cupsSelectedIndex) {
              ForEach(1..<21) { amount in
                amount == 1 ? Text("1 cup") : Text("\(amount) cups")
              }
            }
          }
        }
      }
      .navigationBarTitle("BetterRest")
    }
  }
  
  func calculateBedtime() -> (header: String, message: String) {
    let components = Calendar.current.dateComponents([.hour, .minute],
                                                     from: wakeUp)
    let hour = (components.hour ?? 0) * 60 * 60
    let minute = (components.minute ?? 0) * 60
    do {
      let model = try SleepCalculator(configuration: MLModelConfiguration())
      let prediction = try model.prediction(
        wake: Double(hour + minute),
        estimatedSleep: sleepAmount,
        coffee: Double(coffeeAmount))
      let sleepTime = wakeUp - prediction.actualSleep
      let formatter = DateFormatter()
      formatter.timeStyle = .short
      let result = (header: "Your ideal bedtime is...",
                    message: formatter.string(from: sleepTime))
      return result
    } catch {
      let result = (header:  "Error",
                    message: "Sorry, there was a problem calculating your bedtime.")
      return result
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
