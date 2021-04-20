// ImagePicker.swift
// Instafilter
//
// Creado el 19/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import Foundation

struct ImagePicker: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
  }
}
