// ContactListViewModel.swift
// PeopleNames
//
// Creado el 4/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import UIKit.UIImage

class ContactListViewModel: ObservableObject {
  @Published var contacts = [Contact]()
  @Published var showingImagePicker = false
  @Published var newContactImage: UIImage? = nil
  @Published var showingAddView = false
  
  let dataService: DataService
  
  init(_ dataService: DataServiceOption = .runtime) {
    self.dataService = dataService.createDataService()
    getAllContacts()
  }
  
  func getAllContacts() {
    dataService.getAllContacts { [weak self] result, error in
      if let result = result {
        self?.contacts = result
      } else if let error = error {
        print("Error getting all contacts: \(error)")
      }
    }
  }
  
  func onAddButtonAction() {
    showingImagePicker = true
  }
  
  func onImagePickerDismiss() {
    if newContactImage != nil {
      showingAddView = true
    }
  }
}
