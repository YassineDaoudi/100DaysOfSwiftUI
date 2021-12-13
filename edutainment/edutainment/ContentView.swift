//
//  ContentView.swift
//  edutainment
//
//  Created by Yassine DAOUDI on 18/8/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSettings = false
    @State private var startGame = false
    @State private var animationAmount = 0.0
    @State private var scaleAnimationAmount: CGFloat = 1
    @State var multiTable = 1
    @State var numberOfQuestions = 0
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                
                HStack(spacing: 50.0) {
                    
                    Button("Play") {
                        startGame.toggle()
                    }
                    .frame(width: 100, height: 100)
                    .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                            .scaleEffect(scaleAnimationAmount)
                            .opacity(Double(2 - scaleAnimationAmount))
                            .animation(
                                Animation.easeOut(duration: 1)
                                    .repeatForever(autoreverses: false)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                                    .scaleEffect(scaleAnimationAmount)
                                    .opacity(Double(2 - scaleAnimationAmount))
                                    .animation(
                                        Animation.easeOut(duration: 1)
                                            .delay(0.1)
                                            .repeatForever(autoreverses: false)
                                    )
                            )
                    )
                    .shadow(color: Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)).opacity(0.1), radius: 1, x: 0.0, y: 1)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.3), radius: 20, x: 0.0, y: 20)
                    .sheet(isPresented: $startGame, content: {
                        GameView(numberOfQuestions: $numberOfQuestions, multiTable: $multiTable)
                    })
                    .rotation3DEffect(
                        .degrees(animationAmount),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .animation(
                        Animation.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)
                            .speed(0.25)
                    )
                    
                }
            }
            .navigationBarTitle("Multiplication")
            .navigationBarItems(trailing: Button(action: {
                showSettings.toggle()
            }){
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20, weight: .light))
                    .imageScale(.large)
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }
            .sheet(isPresented: $showSettings, content: {
                SettingsView(multiTable: $multiTable, nbrQuestions: $numberOfQuestions)
            })
            )
            .onAppear {
                withAnimation {
                    animationAmount += 360
                }
                self.scaleAnimationAmount = 2
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
