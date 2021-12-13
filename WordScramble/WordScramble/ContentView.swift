//
//  ContentView.swift
//  WordScramble
//
//  Created by Yassine DAOUDI on 13/8/2021.
//

import SwiftUI


struct bodyText: ViewModifier {    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .medium, design: .rounded))
    }
}

extension View {
    func bodyStyle() -> some View {
        self.modifier(bodyText())
    }
}

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
        
        NavigationView {
            
            ZStack {
                
                Color(#colorLiteral(red: 0.1019607843, green: 0.1294117647, blue: 0.3176470588, alpha: 0.95))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    TextField("Enter your word :", text: $newWord, onCommit: addNewWord)
                        .frame(width: 350, height: 50)
                        .bodyStyle()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.alphabet)
                        .padding()
                    
                    
                    List(usedWords, id: \.self) {
                        
                        Text($0)
                            .bodyStyle()
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        
                        Spacer()
                        
                        Image(systemName: "\($0.count).circle")
                            .foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.3215686275, blue: 0.9921568627, alpha: 1)))
                        
                        Image(systemName: "character")
                            .foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.3215686275, blue: 0.9921568627, alpha: 1)))
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .navigationBarTitle(rootWord)
                .onAppear(perform: startGame)
                .navigationBarItems(trailing: Button(action: {
                    startGame()
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30,alignment: .center)
                        .foregroundColor(Color(#colorLiteral(red: 0.07843137255, green: 0.7450980392, blue: 0.9921568627, alpha: 1)))
                })
                .alert(isPresented: $showingError, content: {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                })
                
                Text("Score : \(score)")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .background(Color(#colorLiteral(red: 0, green: 0.8117647059, blue: 0.9921568627, alpha: 1)))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                    .padding(.top, 600)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0  else {
            return
        }
        
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
        
        guard isShort(word: answer) else {
            wordError(title: "Word too short", message: "Word must contain more than 3 letters.")
            return
        }
        
        guard isRootWord(word: answer) else {
            wordError(title: "Root word", message: "Try to be more creative.")
            return
        }
        
        usedWords.insert(newWord, at: 0)
        score += newWord.count
        newWord = ""
        
    }
    
    func startGame() {
        
        usedWords.removeAll()
        score = 0
        newWord = ""
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement()?.capitalized ?? "Silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
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
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledWord = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledWord.location == NSNotFound
    }
    
    func isShort(word: String) -> Bool {
        
        if word.count < 3  {
            return false
        }
        return true
    }
    
    func isRootWord(word: String) -> Bool {
        
        if word == rootWord.lowercased() {
            return false
        }
        return true
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
