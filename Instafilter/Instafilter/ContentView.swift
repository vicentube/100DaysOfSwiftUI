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
  @State private var filterRadius = 100.0
  @State private var filterScale = 5.0
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
  @State private var showingFilterSheet = false
  @State private var processedImage: UIImage?
  @State private var showingNoImageError = false
  @State private var disableIntensity = false
  @State private var disableRadius = false
  @State private var disableScale = false
  
  let context = CIContext()
  
  var body: some View {
    let intensity = Binding<Double>(
      get: { filterIntensity },
      set: {
        filterIntensity = $0
        applyProcessing()
      })
    
    let radius = Binding<Double>(
      get: { filterRadius },
      set: {
        filterRadius = $0
        applyProcessing()
      })
    
    let scale = Binding<Double>(
      get: { filterScale },
      set: {
        filterScale = $0
        applyProcessing()
      })
    
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
        
        VStack {
          HStack {
            Text("Intensity")
            Spacer()
            Slider(value: intensity)
              .frame(maxWidth: 260)
          }
          .disabled(disableIntensity)
          .padding(.vertical)

          HStack {
            Text("Radius")
            Spacer()
            Slider(value: radius, in: 0...200)
              .frame(maxWidth: 260)
          }
          .disabled(disableRadius)
          .padding(.vertical)

          HStack {
            Text("Scale")
            Spacer()
            Slider(value: scale, in: 0...10)
              .frame(maxWidth: 260)
          }
          .disabled(disableScale)
          .padding(.vertical)
        }
        
        HStack {
          let filterName = CIFilter.localizedName(forFilterName: currentFilter.name) ?? "Unknown filter"
          Button(filterName) {
            showingFilterSheet = true
          }
          
          Spacer()
          
          Button("Save") {
            guard let processedImage = processedImage else {
              showingNoImageError = true
              return
            }
            
            let imageSaver = ImageSaver()
            
            imageSaver.successHandler = {
              print("Success!")
            }
            
            imageSaver.errorHandler = {
              print("Oops: \($0.localizedDescription)")
            }
            
            imageSaver.writeToPhotoAlbum(image: processedImage)
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
      .alert(isPresented: $showingNoImageError) {
        Alert(title: Text("Error"),
              message: Text("There is no image loaded."),
              dismissButton: .default(Text("OK")))
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
    disableIntensity =  !inputKeys.contains(kCIInputIntensityKey)
    if !disableIntensity {
      currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
    }
    disableRadius = !inputKeys.contains(kCIInputRadiusKey)
    if !disableRadius {
      currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
    }
    self.disableScale = !inputKeys.contains(kCIInputScaleKey)
    if !disableScale {
      currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
    }
    
    guard let outputImage = currentFilter.outputImage else { return }
    
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      let uiImage = UIImage(cgImage: cgimg)
      image = Image(uiImage: uiImage)
      processedImage = uiImage
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
