// Resort.swift
// SnowSeeker
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Resort: Codable, Identifiable {
  let id: String
  let name: String
  let country: String
  let description: String
  let imageCredit: String
  let price: Int
  let size: Int
  let snowDepth: Int
  let elevation: Int
  let runs: Int
  let facilities: [String]
  var facilityTypes: [Facility] {
    facilities.map(Facility.init)
  }
  
  var sizeText: String {
    switch size {
    case 1:
      return "Small"
    case 2:
      return "Average"
    default:
      return "Large"
    }
  }
  
  var priceText: String {
    String(repeating: "$", count: price)
  }
  
  static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
  static let example = allResorts[0]
}
