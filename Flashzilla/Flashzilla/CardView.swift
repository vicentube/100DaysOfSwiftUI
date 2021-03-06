// CardView.swift
// Flashzilla
//
// Creado el 17/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct CardView: View {
  let card: Card
  var removal: ((Bool) -> Void)? = nil
  
  @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
  @Environment(\.accessibilityEnabled) var accessibilityEnabled
  @State private var isShowingAnswer = false
  @State private var offset = CGSize.zero
  @State private var feedback = UINotificationFeedbackGenerator()
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25, style: .continuous)
        .fill(
          differentiateWithoutColor
            ? Color.white
            : Color.white.opacity(1 - Double(abs(offset.width / 50)))
            .opacity(1 - Double(abs(offset.width / 50)))
        )
        .cardBackgorund(colorBlind: differentiateWithoutColor, offset: offset.width)
        .shadow(radius: 10)
      
      VStack {
        if accessibilityEnabled {
          Text(isShowingAnswer ? card.answer : card.prompt)
            .font(.largeTitle)
            .foregroundColor(.black)
        } else {
          Text(card.prompt)
            .font(.largeTitle)
            .foregroundColor(.black)
          
          if isShowingAnswer {
            Text(card.answer)
              .font(.title)
              .foregroundColor(.gray)
          }
        }
      }
      .padding(20)
      .multilineTextAlignment(.center)
    }
    .frame(width: 450, height: 250)
    .rotationEffect(.degrees(Double(offset.width / 5)))
    .offset(x: offset.width * 5, y: 0)
    .opacity(2 - Double(abs(offset.width / 50)))
    .accessibilityAddTraits(.isButton)
    .gesture(
      DragGesture()
        .onChanged { gesture in
          offset = gesture.translation
          feedback.prepare()
        }
        
        .onEnded { _ in
          if abs(offset.width) > 100 {
            if offset.width > 0 {
              feedback.notificationOccurred(.success)
              removal?(true)
            } else {
              feedback.notificationOccurred(.error)
              removal?(false)
            }
          }
          offset = .zero
        }
    )
    .onTapGesture {
      isShowingAnswer.toggle()
    }
    .animation(.spring())
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
    
  }
}

struct CardBackground: ViewModifier {
  var colorBlind: Bool
  var offset: CGFloat
  
  func body(content: Content) -> some View {
    content
      .background(
        colorBlind
          ? nil
          : RoundedRectangle(cornerRadius: 25, style: .continuous)
          .fill(offset > 0 ? Color.green : (offset == 0 ? Color.white : Color.red))
      )
  }
}

extension View {
  func cardBackgorund(colorBlind: Bool, offset: CGFloat) -> some View {
    self.modifier(CardBackground(colorBlind: colorBlind, offset: offset))
  }
}
