// Test2View.swift
// LayoutAndGeometry
//
// Creado el 21/5/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test2View: View {
    var body: some View {
      HStack(alignment: .midAccountAndName) {
        VStack {
          Text("@twostraws")
            .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
          Image("AppleM1")
            .resizable()
            .frame(width: 64, height: 64)
        }
        
        VStack {
          Text("Full name:")
          Text("PAUL HUDSON")
            .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
            .font(.largeTitle)
        }
      }
    }
}

struct Test2View_Previews: PreviewProvider {
    static var previews: some View {
        Test2View()
    }
}

extension VerticalAlignment {
  enum MidAccountAndName: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
      d[.top]
    }
  }
  
  static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
