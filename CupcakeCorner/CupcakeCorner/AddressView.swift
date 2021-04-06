// AddressView.swift
// CupcakeCorner
//
// Creado el 4/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct AddressView: View {
  @ObservedObject var orderWrapper: OrderWrapper
  
  var body: some View {
    Form {
      Section {
        TextField("Name", text: $orderWrapper.order.name)
        TextField("Street Address", text: $orderWrapper.order.streetAddress)
        TextField("City", text: $orderWrapper.order.city)
        TextField("Zip", text: $orderWrapper.order.zip)
      }
      
      Section {
        NavigationLink(destination: CheckoutView(orderWrapper: orderWrapper)) {
          Text("Check out")
        }
      }
      .disabled(orderWrapper.order.hasValidAddress == false)
    }
    .navigationBarTitle("Delivery details", displayMode: .inline)
  }
}

struct AddressView_Previews: PreviewProvider {
  static var previews: some View {
    AddressView(orderWrapper: OrderWrapper())
  }
}
