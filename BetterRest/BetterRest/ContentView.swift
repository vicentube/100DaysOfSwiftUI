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
  @State private var coffeeAmount = 1
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  
  var body: some View {
    NavigationView {
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
          Stepper(value: $coffeeAmount, in: 1...20) {
            coffeeAmount == 1 ? Text("1 cup") : Text("\(coffeeAmount) cups")
          }
        }
      }
      .navigationBarTitle("BetterRest")
      .navigationBarItems(
        trailing: Button(action: calculateBedtime) {
          Text("Calculate")
        })
      .alert(isPresented: $showingAlert) {
        Alert(title: Text(alertTitle),
              message: Text(alertMessage),
              dismissButton: .default(Text("OK")))
      }
    }
  }
  
  func calculateBedtime() {
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
      alertMessage = formatter.string(from: sleepTime)
      alertTitle = "Your ideal bedtime is…"
    } catch {
      alertTitle = "Error"
      alertMessage = "Sorry, there was a problem calculating your bedtime."
    }
    showingAlert = true
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}