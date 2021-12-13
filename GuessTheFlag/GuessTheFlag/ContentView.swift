//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yassine DAOUDI on 6/8/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var counter = 0
    
    @State private var animationAmount = 0.0
    @State private var scaleAmount: CGFloat = 1


    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4470588235, green: 0.8117647059, blue: 0.831372549, alpha: 1)), Color(#colorLiteral(red: 0.2588235294, green: 0.6274509804, blue: 0.7607843137, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 40.0) {
                
                VStack(spacing: 10.0) {
                    
                    Text("Tap the flag of")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold, design: .monospaced))
                        
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold, design: .monospaced))
                        .animation(.easeInOut(duration: 1))
                    }
               
                
                
                ForEach(0..<3) { number in
                    Button(action: {
                      
                        if counter < 10 {
                        
                            self.flagTapped(number)
                            self.askQuestion()
                           
                        } else {
                            showingScore = true
                        }
                    }) {
                        FlagImage(countryName: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount : 0), axis: (x: 0, y: 0, z: 1))
                    .scaleEffect(scaleAmount)
                }
                
                
                Spacer()
                
                VStack(spacing: 10.0) {
                    Text(scoreTitle)
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .animation(.easeInOut(duration: 1))
                        
                    
                    Text("Your current score is: \(score)")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                }
            }
            .padding(.top, 100)
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("End of the Game"), message: Text("Your final score is \(score) / 10. Wanna try again ?"), dismissButton: .default(Text("play again")) {
                self.askQuestion()
                self.score = 0
                self.counter = 0
                self.scoreTitle = ""
                scaleAmount = 1
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            
            scoreTitle = "Correct"
            score += 1
            
            withAnimation {
                self.animationAmount += 360
            }
           
        } else {
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 1)) {
                self.scaleAmount += 0.03
            }
            
            scoreTitle = "Wrong ! That's the flag of \(self.countries[number])"
        }
        counter += 1
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct FlagImage: View {
    
    var countryName: String = ""
    
    var body: some View {
        Image(countryName)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color.black, lineWidth: 1))
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
        
    }
}
