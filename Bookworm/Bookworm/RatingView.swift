// RatingView.swift
// Bookworm
//
// Creado el 8/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct RatingView: View {
  @Binding var rating: Int
  
  var label = ""
  
  var maximumRating = 5
  
  var offImage: Image?
  var onImage = Image(systemName: "star.fill")
  
  var offColor = Color.gray
  var onColor = Color.yellow
  
  var body: some View {
    HStack {
      if label.isEmpty == false {
        Text(label)
      }
      
      ForEach(1..<maximumRating + 1) { number in
        image(for: number)
          .foregroundColor(number > rating ? offColor : onColor)
          .onTapGesture {
            rating = number
          }
      }
    }
  }
  
  func image(for number: Int) -> Image {
    if number > rating {
      return offImage ?? onImage
    } else {
      return onImage
    }
  }
}

struct RatingView_Previews: PreviewProvider {
  static var previews: some View {
    RatingView(rating: .constant(4))
  }
}
