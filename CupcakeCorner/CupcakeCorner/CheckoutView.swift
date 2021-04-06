// CheckoutView.swift
// CupcakeCorner
//
// Creado el 4/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct CheckoutView: View {
  @ObservedObject var orderWrapper: OrderWrapper
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  
  var body: some View {
    GeometryReader { geo in
      ScrollView {
        VStack {
          Image("cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)
          
          Text("Your total is $\(self.orderWrapper.order.cost, specifier: "%.2f")")
            .font(.title)
          
          Button("Place Order") {
            placeOrder()
          }
          .padding()
        }
      }
    }
    .navigationBarTitle("Check out", displayMode: .inline)
    .alert(isPresented: $showingAlert) {
      Alert(
        title: Text(alertTitle),
        message: Text(alertMessage),
        dismissButton: .default(Text("OK")))
    }
  }
  
  func placeOrder() {
    guard let encoded = try? JSONEncoder().encode(orderWrapper.order) else {
      print("Failed to encode order")
      return
    }
    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url, timeoutInterval: 5)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encoded
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
        alertTitle = "Error"
        alertMessage = "There was an error connecting to the server."
        showingAlert = true
        return
      }
      if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
        alertTitle = "Thank you!"
        alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
        showingAlert = true
      } else {
        print("Invalid response from server")
      }
    }.resume()
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(orderWrapper: OrderWrapper())
  }
}
