// ContentView.swift
// CupcakeCorner
//
// Creado el 2/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @ObservedObject var order = Order()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Select your cake type", selection: $order.type) {
            ForEach(0..<Order.types.count, id: \.self) {
              Text(Order.types[$0])
            }
          }
          Stepper(value: $order.quantity, in: 3...20) {
            Text("Number of cakes: \(order.quantity)")
          }
        }
        
        Section {
          Toggle(isOn: $order.specialRequestEnabled.animation()) {
            Text("Any special requests?")
          }
          
          if order.specialRequestEnabled {
            Toggle(isOn: $order.extraFrosting) {
              Text("Add extra frosting")
            }
            
            Toggle(isOn: $order.addSprinkles) {
              Text("Add extra sprinkles")
            }
          }
        }
        
        Section {
          NavigationLink(destination: AddressView(order: order)) {
            Text("Delivery details")
          }
        }
      }
      .navigationBarTitle("Cupcake Corner")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
