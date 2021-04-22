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
  @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
  @State private var showingFilterSheet = false
  
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
            showingFilterSheet = true
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
      .actionSheet(isPresented: $showingFilterSheet) {
        ActionSheet(title: Text("Select a filter"), buttons: [
          .default(Text("Crystallize")) { setFilter(CIFilter.crystallize()) },
          .default(Text("Edges")) { setFilter(CIFilter.edges()) },
          .default(Text("Gaussian Blur")) { setFilter(CIFilter.gaussianBlur()) },
          .default(Text("Pixellate")) { setFilter(CIFilter.pixellate()) },
          .default(Text("Sepia Tone")) { setFilter(CIFilter.sepiaTone()) },
          .default(Text("Unsharp Mask")) { setFilter(CIFilter.unsharpMask()) },
          .default(Text("Vignette")) { setFilter(CIFilter.vignette()) },
          .cancel()
        ])
      }
    }
  }
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    
    let beginImage = CIImage(image: inputImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }
  
  func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()
  }
  
  func applyProcessing() {
    let inputKeys = currentFilter.inputKeys
    if inputKeys.contains(kCIInputIntensityKey) {
      currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
    }
    if inputKeys.contains(kCIInputRadiusKey) {
      currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
    }
    if inputKeys.contains(kCIInputScaleKey) {
      currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
    }
    
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
