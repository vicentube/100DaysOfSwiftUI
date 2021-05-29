// ResortView.swift
// SnowSeeker
//
// Creado el 27/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ResortView: View {
  @EnvironmentObject var favorites: Favorites
  @Environment(\.horizontalSizeClass) var sizeClass
  let resort: Resort
  
  @State private var selectedFacility: Facility?
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        imageView
        
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
      Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
        if self.favorites.contains(self.resort) {
          self.favorites.remove(self.resort)
        } else {
          self.favorites.add(self.resort)
        }
      }
      .padding()
    }
    .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    .alert(item: $selectedFacility) { facility in
      facility.alert
    }
  }
  
  var imageView: some View {
    Image(decorative: resort.id)
      .resizable()
      .scaledToFit()
      .overlay(
        VStack {
          Spacer()
          HStack {
            Spacer()
            Text("Photo by: \(resort.imageCredit)")
              .font(.footnote)
              .foregroundColor(.white)
              .padding(.horizontal, 5)
              .shadow(color: .black, radius: 2, x: 0.0, y: 0.0)
          }
        })
  }
}
struct ResortView_Previews: PreviewProvider {
  static var previews: some View {
    ResortView(resort: Resort.example).environmentObject(Favorites())
  }
}
