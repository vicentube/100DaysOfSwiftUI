// ItemAmountView.swift
// iExpense
//
// Creado el 19/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ItemAmountView: View {
  @State private var animating = false
  var amount: Int
  
  let formatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .currency
    return nf
  }()
  
  var body: some View {
    let text = formatter.string(from: NSNumber(value: amount)) ?? ""
    Group {
      switch amount {
      case let x where x < 10:
        Text(text + " 😀")
          .foregroundColor(.green)
      case let x where x < 100:
        Text(text + " 😬")
          .foregroundColor(.red)
      default:
        Text(text + " 🤬")
          .foregroundColor(.red)
          .fontWeight(.black)
          .opacity(animating ? 0.25 : 1)
      }
    }
    .onAppear(perform: {
      withAnimation(Animation.default.repeatForever()) {
        animating = true
      }
    })
  }
}

struct ItemAmountView_Previews: PreviewProvider {
  static var previews: some View {
    ItemAmountView(amount: 500)
  }
}
