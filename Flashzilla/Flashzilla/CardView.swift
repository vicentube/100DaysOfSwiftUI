// CardView.swift
// Flashzilla
//
// Creado el 17/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct CardView: View {
  let card: Card
  
  @State private var isShowingAnswer = false
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25, style: .continuous)
        .fill(Color.white)
        .shadow(radius: 10)
      
      VStack {
        Text(card.prompt)
          .font(.largeTitle)
          .foregroundColor(.black)
        if isShowingAnswer {
          Text(card.answer)
            .font(.title)
            .foregroundColor(.gray)
        }
      }
      .padding(20)
      .multilineTextAlignment(.center)
    }
    .frame(width: 450, height: 250)
    .onTapGesture {
      isShowingAnswer.toggle()
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
      
  }
}
