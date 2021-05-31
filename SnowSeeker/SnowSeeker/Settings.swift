// Settings.swift
// SnowSeeker
//
// Creado el 29/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Settings {
  var sortingField = SortingField.none
  var filterByCountry = false
  var filterBySize = false
  var filterByPrice = false
  var selectedCountry = ""
  var selectedSize = 0
  var selectedPrice = 0
}
