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
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
