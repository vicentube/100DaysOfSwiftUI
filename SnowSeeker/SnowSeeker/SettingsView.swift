// SettingsView.swift
// SnowSeeker
//
// Creado el 29/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct SettingsView: View {
  @Environment(\.presentationMode) var presentationMode
  let resorts: [Resort]
  @Binding var sortedAndFiltered: [Resort]
  @Binding var settings: Settings
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Sort")) {
          Picker("Choose sorting field", selection: $settings.sortingField) {
            ForEach(SortingField.allCases, id: \.self) {
              Text($0.title())
            }
          }
        }
        
        Section(header: Text("Filtering")) {
          Toggle("By country", isOn: $settings.filterByCountry)
          Picker("Choose country", selection: $settings.selectedCountry) {
            ForEach(countries, id: \.self) { country in
              Text(country)
            }
          }
          .hidden(!settings.filterByCountry)
          Toggle("By size", isOn: $settings.filterBySize)
          Picker("Choose size", selection: $settings.selectedSize) {
            ForEach(sizes, id: \.self) { size in
              Text(sizeText(size))
            }
          }
          .hidden(!settings.filterBySize)
          Toggle("By price", isOn: $settings.filterByPrice)
          Picker("Choose price", selection: $settings.selectedPrice) {
            ForEach(prices, id: \.self) { price in
              Text(priceText(price))
            }
          }
          .hidden(!settings.filterByPrice)
        }
      }
      .navigationBarTitle("Sorting and Filtering")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading, content: {
          Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Text("Cancel")
          }
        })
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: onTapDone) {
            Text("Done")
          }
        }
      }
    }
  }
  
  var countries: [String] {
    Array(Set(resorts.map { $0.country }))
  }
  
  var sizes: [Int] {
    Array(Set(resorts.map { $0.size }))
  }
  
  var prices: [Int] {
    Array(Set(resorts.map { $0.price }))
  }
  
  func sizeText(_ size: Int) -> String {
    switch size {
    case 1:
      return "Small"
    case 2:
      return "Average"
    default:
      return "Large"
    }
  }
  
  func priceText(_ price: Int) -> String {
    String(repeating: "$", count: price)
  }
  
  func onTapDone() {
    var newList = resorts
    switch settings.sortingField {
    case .name:
      newList = resorts.sorted(by: { $0.name < $1.name })
    case .country:
      newList = resorts.sorted(by: { $0.country < $1.country })
    default:
      break
    }
    if settings.filterByCountry {
      newList = newList.filter({ $0.country == settings.selectedCountry })
    }
    if settings.filterBySize {
      newList = newList.filter({ $0.size == settings.selectedSize })
    }
    if settings.filterByPrice {
      newList = newList.filter({ $0.price == settings.selectedPrice })
    }
    sortedAndFiltered = newList
    presentationMode.wrappedValue.dismiss()
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    SettingsView(
      resorts: resorts,
      sortedAndFiltered: .constant([]),
      settings: .constant(Settings())
    )
  }
}

extension View {
  @ViewBuilder func hidden(_ hidden: Bool, remove: Bool = true) -> some View {
    if hidden {
      if !remove {
        self.hidden()
      }
    } else {
      self
    }
  }
}
