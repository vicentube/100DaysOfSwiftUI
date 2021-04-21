// ContentView.swift
// Instafilter
//
// Creado el 18/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
  @State private var image: Image?
  @State private var filterIntensity = 0.5
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  @State private var currentFilter = CIFilter.sepiaTone()
  
  let context = CIContext()
  
  var body: some View {
    let intensity = Binding<Double>(
      get: {
        filterIntensity
      },
      set: {
        filterIntensity = $0
        applyProcessing()
      }
    )
    
    return NavigationView {
      VStack {
        ZStack {
          Rectangle()
            .fill(Color.secondary)
          
          if let image = image {
            image
              .resizable()
              .scaledToFit()
          } else {
            Text("Tap to select a picture")
              .foregroundColor(.white)
              .font(.headline)
          }
        }
        .onTapGesture {
          showingImagePicker = true
        }
        
        HStack {
          Text("Intensity")
          Slider(value: intensity)
        }
        .padding(.vertical)
        
        HStack {
          Button("Change Filter") {
            // Change filter
          }
          
          Spacer()
          
          Button("Save") {
            // Save the picture
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationBarTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
        ImagePicker(image: $inputImage)
      }
    }
  }
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    
    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }
  
  func applyProcessing() {
    currentFilter.intensity = Float(filterIntensity)
    
    guard let outputImage = currentFilter.outputImage else { return }
    
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
