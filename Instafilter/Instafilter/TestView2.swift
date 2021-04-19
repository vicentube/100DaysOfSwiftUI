// TestView2.swift
// Instafilter
//
// Creado el 19/4/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct TestView2: View {
  @State private var image: Image?
  @State private var showingImagePicker = false
  
  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
      
      Button("Select Image") {
        self.showingImagePicker = true
      }
      .sheet(isPresented: $showingImagePicker) {
        ImagePicker()
      }
    }
  }
  
  func loadImage() {
    guard let inputImage = UIImage(named: "Example") else { return }
    let beginImage = CIImage(image: inputImage)
    
    let context = CIContext()
    
    //    let currentFilter = CIFilter.sepiaTone()
    //    currentFilter.inputImage = beginImage
    //    currentFilter.intensity = 1
    
    //    let currentFilter = CIFilter.pixellate()
    //    currentFilter.inputImage = beginImage
    //    currentFilter.scale = 100
    
    //    let currentFilter = CIFilter.crystallize()
    //        //currentFilter.inputImage = beginImage
    //        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    //    currentFilter.radius = 200
    
    guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
    currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
    
    // get a CIImage from our filter or exit if that fails
    guard let outputImage = currentFilter.outputImage else { return }
    
    // attempt to get a CGImage from our CIImage
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      // convert that to a UIImage
      let uiImage = UIImage(cgImage: cgimg)
      
      // and convert that to a SwiftUI image
      image = Image(uiImage: uiImage)
    }
  }
}

struct TestView2_Previews: PreviewProvider {
  static var previews: some View {
    TestView2()
  }
}
