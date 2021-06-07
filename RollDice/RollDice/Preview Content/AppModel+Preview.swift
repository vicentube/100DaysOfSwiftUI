// AppModel.swift
// RollDice
//
// Creado el 6/6/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

extension AppModel {  
  static var preview: AppModel {
    AppModel(dataService: PreviewDataService(), settingsService: PreviewSettingsService())
  }
}
