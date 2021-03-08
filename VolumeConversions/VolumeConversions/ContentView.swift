// ContentView.swift
// VolumeConversions
//
// Creado el 27/2/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

enum Unit: String, CaseIterable {
  case milliliters = "ml"
  case liters = "L"
  case cups = "C"
  case pints = "pt"
  case gallons = "gal"
  
  func convertToMl(value: Double) -> Double {
    switch(self) {
    case .milliliters:
      return value
    case .liters:
      return value * 1000.0
    case .cups:
      return value * 236.588
    case .pints:
      return value * 473.176
    case .gallons:
      return value * 3785.41
    }
  }
  
  func convertFromMl(value: Double) -> Double {
    switch(self) {
    case .milliliters:
      return value
    case .liters:
      return value / 1000.0
    case .cups:
      return value / 236.588
    case .pints:
      return value / 473.176
    case .gallons:
      return value / 3785.41
    }
  }
}

extension NumberFormatter {
  static var decimal: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.numberStyle = .decimal
    return formatter
  }
}

struct ContentView: View {
  @State private var inputText = ""
  @State private var inputUnit = Unit.liters
  @State private var outputUnit = Unit.gallons
    
  let formatter = NumberFormatter.decimal
  
  var outputValue: Double {
    let inputValue = Double(truncating: formatter.number(from: inputText) ?? 0.0)
    let mlValue = inputUnit.convertToMl(value: inputValue)
    let resultValue = outputUnit.convertFromMl(value: mlValue)
    
    return resultValue
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Convert")) {
          TextField("Enter volume", text: $inputText)
            .keyboardType(.decimalPad)
          Picker("Input Unit", selection: $inputUnit) {
            ForEach(Unit.allCases, id: \.self) { unit in
              Text("\(unit.rawValue)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        Section(header: Text("To")) {
          Picker("Input Unit", selection: $outputUnit) {
            ForEach(Unit.allCases, id: \.self) { unit in
              Text("\(unit.rawValue)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        Section(header: Text("Result")) {
          Text("\(outputValue, specifier: "%g") \(outputUnit.rawValue)")
        }
      }
      .navigationBarTitle("Volume Conversion")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
