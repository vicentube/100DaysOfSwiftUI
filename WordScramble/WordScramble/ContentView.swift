// ContentView.swift
// WordScramble
//
// Creado el 10/3/21 por Vicente Úbeda (@vicentube)
// https://appeleando.com
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct ContentView: View {
  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var showingError = false
  @State private var score = 0
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord, onCommit: addNewWord)
          .autocapitalization(.none)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        GeometryReader { geoParent in
          List {
            ForEach(usedWords, id: \.self) { useWord in
              GeometryReader { geoChild in
                HStack {
                  Image(systemName: "\(useWord.count).circle")
                    .foregroundColor(
                      Color(.sRGB,
                            red: getColor(parent: geoParent, child: geoChild),
                            green: 0.0,
                            blue: 0.0,
                            opacity: 1.0)
                    )
                  Text(useWord)
                }
                .accessibilityElement(children: .ignore)
                .accessibility(label: Text("\(useWord), \(useWord.count) letters"))
                .offset(x: getOffset(parent: geoParent, child: geoChild), y: 0)
              }
            }
            Text("Score: \(score)")
              .fontWeight(.bold)
          }
        }
      }
      .navigationBarTitle(rootWord)
      .navigationBarItems(
        leading: Button("New Game", action: startGame))
      .onAppear(perform: startGame)
      .alert(isPresented: $showingError) {
        Alert(
          title: Text(errorTitle),
          message: Text(errorMessage),
          dismissButton: .default(Text("OK")))
      }
    }
  }
  
  func getColor(parent: GeometryProxy, child: GeometryProxy) -> Double {
    let parentRect = parent.frame(in: .global)
    let top = parentRect.minY
    let pos = child.frame(in: .global).minY - top
    let maxPos = parentRect.height
    let color = Double(pos / maxPos)
    if color < 0.0 {
      return 0.0
    } else if color > 1.0 {
      return 1.0
    } else {
      return color
    }
  }
  
  func getOffset(parent: GeometryProxy, child: GeometryProxy) -> CGFloat {
    let top = parent.frame(in: .global).minY
    let pos = child.frame(in: .global).minY
    let offset = pos - top - 200
    if offset < 0 {
      return 0
    } else {
      return offset
    }
  }
  
  func addNewWord() {
    // lowercase and trim the word, to make sure we don't add duplicate words with case differences
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    
    // exit if the remaining string is empty
    guard answer.count > 0 else { return }
    
    guard isOriginal(word: answer) else {
      wordError(title: "Word used already", message: "Be more original")
      return
    }
    
    guard isPossible(word: answer) else {
      wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
      return
    }
    
    guard isReal(word: answer) else {
      wordError(title: "Word not possible", message: "That isn't a real word.")
      return
    }
    
    score += answer.count + usedWords.count
    usedWords.insert(answer, at: 0)
    newWord = ""
  }
  
  func startGame() {
    // 1. Find the URL for start.txt in our app bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      // 2. Load start.txt into a string
      if let startWords = try? String(contentsOf: startWordsURL) {
        // 3. Split the string up into an array of strings, splitting on line breaks
        let allWords = startWords.components(separatedBy: "\n")
        
        // 4. Pick one random word, or use "silkworm" as a sensible default
        rootWord = allWords.randomElement() ?? "silkworm"
        
        usedWords.removeAll()
        newWord = ""
        score = 0
        
        // If we are here everything has worked, so we can exit
        return
      }
    }
    
    // If we are *here* then there was a problem - trigger a crash and report the error
    fatalError("Could not load start.txt from bundle.")
  }
  
  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word) && (word != rootWord)
  }
  
  func isPossible(word: String) -> Bool {
    var tempWord = rootWord
    
    for letter in word {
      if let pos = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: pos)
      } else {
        return false
      }
    }
    
    return true
  }
  
  func isReal(word: String) -> Bool {
    if word.count < 3 {
      return false
    }
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(
      in: word,
      range: range,
      startingAt: 0,
      wrap: false,
      language: "en")
    
    return misspelledRange.location == NSNotFound
  }
  
  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    showingError = true
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
