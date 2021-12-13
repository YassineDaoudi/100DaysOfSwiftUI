//
//  ContentView.swift
//  Janken
//
//  Created by Yassine DAOUDI on 9/8/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var appChoice = 0
    @State private var playerChoice = 0
    @State private var shouldWin = false
    @State private var score = 0
    @State private var result = false
    @State private var appMove = Int.random(in: 0...2)
    @State private var counter = 0
    @State private var showAlert = false
    
    var moves = ["Rock", "Paper", "Scissors"]
    var icons = ["flame", "doc.plaintext", "scissors"]
    
 
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(alignment: .center) {
                    
                    VStack(spacing: 10.0) {
                        Text("App's Move : \(moves[appMove])")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            
                        
                        Text(shouldWin ? "You should win" : "You should lose")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                    }
                    
                    
                    HStack(spacing: 30.0) {
                        ForEach(0..<moves.count) { number in
                            Button(action: {
                                
                                counter += 1
                               
                                if counter < 11 {
                                    
                                    result = self.janken(userMove: moves[number], appMove: moves[appMove])
                                    
                                    if result && shouldWin || !result && !shouldWin {
                                        score += 1
                                    } else {
                                        score -= 1
                                    }
                                    
                                    again()
                                    
                                } else {
                                    showAlert = true
                                }
                            })
                            {
                                Text("\(moves[number])")
                                    .foregroundColor(.white)
                                    .font(.system(.headline, design: .rounded))
                                    .frame(width: 100, height: 50)
                                    .background(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.top, 200)
                    Spacer()
                    Text("Your current score is : \(score)")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                }
                .padding(.top, 150)
            }
            .navigationBarTitle("Janken")
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("End of the Game"), message: Text("Your final score is \(score) / 10. Wanna try again ?"), dismissButton: .default(Text("play again")){
                    counter = 0
                    score = 0
                    again()
                } )
            })
            
            
        }
    }
    
    
    func janken(userMove: String, appMove: String) -> Bool {
        if userMove == "Paper" && appMove == "Rock" {
            return true
        } else if userMove == "Rock" && appMove == "Scissors" {
            return true
        } else if userMove == "Scissors" && appMove == "Paper" {
            return true
        } else {
            return false
        }
    }
    
    func again(){
        shouldWin.toggle()
        appMove = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
