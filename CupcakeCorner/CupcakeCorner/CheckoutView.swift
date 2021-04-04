// CheckoutView.swift
// CupcakeCorner
//
// Creado el 4/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct CheckoutView: View {
  @ObservedObject var order: Order
  
  var body: some View {
    GeometryReader { geo in
      ScrollView {
        VStack {
          Image("cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)
          
          Text("Your total is $\(self.order.cost, specifier: "%.2f")")
            .font(.title)
          
          Button("Place Order") {
            // place the order
          }
          .padding()
        }
      }
    }
    .navigationBarTitle("Check out", displayMode: .inline)
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
