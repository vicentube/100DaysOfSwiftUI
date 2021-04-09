// EmojiRatingView.swift
// Bookworm
//
// Creado el 8/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct EmojiRatingView: View {
  let rating: Int16
  
  var body: some View {
    switch rating {
    case 1:
      return Text("💩")
    case 2:
      return Text("🤨")
    case 3:
      return Text("🤔")
    case 4:
      return Text("😉")
    default:
      return Text("😍")
    }
  }
}

struct EmojiRatingView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiRatingView(rating: 3)
  }
}
