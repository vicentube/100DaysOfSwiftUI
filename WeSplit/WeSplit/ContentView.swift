// ContentView.swift
// WeSplit
//
// Creado el 24/2/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = ""
  @State private var numberOfPeople = ""
  @State private var tipPercentage = 2
  
  let tipPercentages = [10, 15, 20, 25, 0]
  
  var grandTotal: Double {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.numberStyle = .decimal
    let orderAmount = Double(truncating: formatter.number(from: checkAmount) ?? 0.0)
    let tipSelection = Double(tipPercentages[tipPercentage])
    let tipValue = orderAmount / 100 * tipSelection
    
    return orderAmount + tipValue
  }
  
  var totalPerPerson: String {
    let peopleCount = Double(numberOfPeople) ?? 1
    let amountPerPerson = grandTotal / peopleCount
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.numberStyle = .currency
    
    return formatter.string(from: NSNumber(value: amountPerPerson)) ?? ""
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)
          
          TextField("Number of people", text: $numberOfPeople)
            .keyboardType(.numberPad)
        }
        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0 ..< tipPercentages.count) {
              Text("\(self.tipPercentages[$0])%")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        Section(header: Text("Total amount of the check")) {
          Text("$\(grandTotal, specifier: "%.2f")")
        }
        Section(header: Text("Amount per person")) {
          Text(totalPerPerson)
        }
      }
      .navigationBarTitle("WeSplit")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
