// Result.swift
// BucketList
//
// Creado el 27/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

struct Result: Codable {
  let query: Query
}

struct Query: Codable {
  let pages: [Int: Page]
}

struct Page: Codable {
  let pageid: Int
  let title: String
  let terms: [String: [String]]?
}
