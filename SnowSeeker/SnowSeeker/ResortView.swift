// ResortView.swift
// SnowSeeker
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ResortView: View {
  @Environment(\.horizontalSizeClass) var sizeClass
  let resort: Resort
  
  @State private var selectedFacility: Facility?
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        Image(decorative: resort.id)
          .resizable()
          .scaledToFit()
        
        Group {
          HStack {
            if sizeClass == .compact {
              Spacer()
              VStack { ResortDetailsView(resort: resort) }
              VStack { SkiDetailsView(resort: resort) }
              Spacer()
            } else {
              ResortDetailsView(resort: resort)
              Spacer().frame(height: 0)
              SkiDetailsView(resort: resort)
            }
          }
          .font(.headline)
          .foregroundColor(.secondary)
          .padding(.top)
          Text(resort.description)
            .padding(.vertical)
          
          Text("Facilities")
            .font(.headline)
          
          HStack {
            ForEach(resort.facilityTypes) { facility in
              facility.icon
                .font(.title)
                .onTapGesture {
                  self.selectedFacility = facility
                }
            }
          }
          .padding(.vertical)
        }
        .padding(.horizontal)
      }
    }
    .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    .alert(item: $selectedFacility) { facility in
      facility.alert
    }
  }
}
struct ResortView_Previews: PreviewProvider {
  static var previews: some View {
    ResortView(resort: Resort.example)
  }
}
