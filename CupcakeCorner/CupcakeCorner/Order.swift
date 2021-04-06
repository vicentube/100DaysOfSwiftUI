// Order.swift
// CupcakeCorner
//
// Creado el 4/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

class OrderWrapper: ObservableObject {
  @Published var order: Order = Order()
}

struct Order: Codable {
  static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
  
  var type = 0
  var quantity = 3
  
  var specialRequestEnabled = false {
    didSet {
      if specialRequestEnabled == false {
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
  var extraFrosting = false
  var addSprinkles = false
  
  var name = ""
  var streetAddress = ""
  var city = ""
  var zip = ""
  
  var hasValidAddress: Bool {
    if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      return false
    }
    
    return true
  }
  
  var cost: Double {
    // $2 per cake
    var cost = Double(quantity) * 2
    
    // complicated cakes cost more
    cost += (Double(type) / 2)
    
    // $1/cake for extra frosting
    if extraFrosting {
      cost += Double(quantity)
    }
    
    // $0.50/cake for sprinkles
    if addSprinkles {
      cost += Double(quantity) / 2
    }
    
    return cost
  }
}
