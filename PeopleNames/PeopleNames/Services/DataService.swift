// DataService.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

protocol DataService {
  func getAllContacts(_ completion: @escaping ([Contact]?, String?) -> Void)
}

enum DataServiceOption {
  case runtime, coreData, encodedFile, preview
}

extension DataServiceOption {
  func createDataService() -> DataService {
    switch self {
    case .runtime:
      return PreviewDataService()
    case .coreData:
      return CDDataService()
    default:
      return PreviewDataService()
    }
  }
}
