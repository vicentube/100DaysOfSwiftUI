// Test3View.swift
// BucketList
//
// Creado el 24/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct Test3View: View {
  var loadingState = LoadingState.loading
  
  var body: some View {
    Group {
      if loadingState == .loading {
        LoadingView()
      } else if loadingState == .success {
        SuccessView()
      } else if loadingState == .failed {
        FailedView()
      }
    }
  }
  
  enum LoadingState {
    case loading, success, failed
  }
  
  struct LoadingView: View {
    var body: some View {
      Text("Loading...")
    }
  }
  
  struct SuccessView: View {
    var body: some View {
      Text("Success!")
    }
  }
  
  struct FailedView: View {
    var body: some View {
      Text("Failed.")
    }
  }
}

struct Test3View_Previews: PreviewProvider {
  static var previews: some View {
    Test3View()
  }
}
