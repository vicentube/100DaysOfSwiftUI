// ImageView.swift
// PeopleNames
//
// Creado el 6/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension Image {
  init(contactImage: UIImage?) {
    if let image = contactImage {
      self.init(uiImage: image)
    } else {
      self.init(systemName: "photo.fill")
    }
  }
}
