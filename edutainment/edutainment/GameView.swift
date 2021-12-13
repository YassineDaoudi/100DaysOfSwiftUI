//
//  GameView.swift
//  edutainment
//
//  Created by Yassine DAOUDI on 18/8/2021.
//

import SwiftUI

struct GridStack<Content: View>: View {
    
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}


struct GameView: View {
    
    @Binding var numberOfQuestions: Int
    @Binding var multiTable: Int
    
    @State private var showingAlert = false
    @State private var isGameStarting = false
    
    @State private var multiplicand = Int.random(in: 1...12)
    @State private var multiplier = 1
    @State private var animal1 = Int.random(in: 0...29)
    @State private var animal2 = Int.random(in: 0...29)
    
    @State private var counter = 0
    @State private var score = 0
    @State private var rows = 0
    @State private var columns = 0
    @State private var timeRemaining = 5
    
    @State private var result = ""

    @State private var animationAmount = 0.0
    @State private var animationTimer = 0.0
    @State private var scaleAnimationAmountCircle: CGFloat = 1
    @State private var scaleAnimationAmountNumber: CGFloat = 1


    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var images = ["bear","buffalo","chick","chicken","cow","crocodile","dog","duck","elephant","frog","giraffe","goat","gorilla","hippo","horse","monkey","moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rhino","sloth","snake","walrus","whale","zebra",].shuffled()
    
    var questions = ["5", "10", "20", "All"]
    
    var body: some View {
        
         ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10.0) {
                
                
                Text(multiTable <= 1 ? "Table \(multiTable)" : "Up to table \(multiTable)")
                    .padding(.top, 50)
                    .font(.system(size: 28, weight: .bold, design: .monospaced))
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                    .opacity(isGameStarting ? 1 : 0)
                    .animation(.spring(response: 0.7, dampingFraction: 0.4, blendDuration: 0))
                
                Spacer()
                
                VStack(alignment: .center, spacing: 50.0) {
                    
                    Text(isGameStarting ? "Go!" : "Are you ready ?")
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .opacity(isGameStarting ? 0 : 1)
                        .animation(Animation.easeInOut.delay(1))
                    
                    Text("\(timeRemaining)")
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        .frame(width: 50, height: 50, alignment: .center)
                        .rotation3DEffect(
                            .degrees(animationTimer),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .overlay(
                            Circle()
                                .stroke()
                                .scaleEffect(scaleAnimationAmountCircle)
                                .opacity(Double(2 - scaleAnimationAmountCircle))
                                .animation(
                                    Animation.easeOut(duration: 1)
                                        .repeatForever(autoreverses: false)
                                )
                        )
                        .scaleEffect(scaleAnimationAmountNumber)
                        .animation(.spring(response: 0.7, dampingFraction: 0.4, blendDuration: 0))
                        .opacity(isGameStarting ? 0 : 1)
                        .animation(.easeInOut)
                }
                .foregroundColor(Color(.black))
                
                                
                HStack(alignment: .center, spacing: 17.0) {

                    /* cols * rows = currentNumber
                                cols = current / rows
                                rows = current / cols
                     */
                    //Text("\(multiplicand)")
                    GridStack(rows: Int(sqrt(Double(multiplicand))), columns: Int(sqrt(Double(multiplicand)))) { row, col in
                        withAnimation {
                            VStack {
                            Image(images[animal1])
                                .resizable()
                                .frame(width: 32, height: 32)
                           }
                        }
                    }
                    .animation(.easeOut(duration: 1))
                    
                    Text(" x ")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    //Text("\(multiplier)")
                    GridStack(rows: Int(sqrt(Double(multiplier))), columns: Int(sqrt(Double(multiplier)))) { row, col in
                        withAnimation {
                           VStack {
                            Image(images[animal2])
                                .resizable()
                                .frame(width: 32, height: 32)
                           }
                        }
                    }
                    .animation(.easeOut(duration: 1))
                    
                    Text(" = ")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    TextField("#",text: $result)
                        .frame(width: 40, height: 40)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                }
                .rotation3DEffect(.degrees(animationAmount),
                    axis: (x: 1.0, y: 0.0, z: 1.0)
                )
                .opacity(isGameStarting ? 1 : 0)
                .animation(.spring(response: 0.7, dampingFraction: 0.4, blendDuration: 0))
                
                Button(action: {
                   
                    if counter <= Int(questions[numberOfQuestions]) ?? 5 {
                        
                        counter += 1
                        
                        withAnimation {
                            animationAmount += 360
                        }
                        
                        self.checkAnswer(number: multiplicand, fresult: result)
                        
                    } else {
                        showingAlert = true
                    }
                }, label: {
                    Text(counter == Int(questions[numberOfQuestions]) ?? 5 ? "Check" : "Next")
                        .frame(width: 100, height: 50, alignment: .center)
                        .foregroundColor(.white)
                        .font(.title2)
                        .background(isGameStarting ? Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)) : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 10)
                })
                .padding(.top, 50)
                .disabled(isGameStarting ? false : true)
                .opacity(isGameStarting ? 1 : 0)
                .animation(.spring(response: 0.7, dampingFraction: 0.4, blendDuration: 0))
                
                
                Spacer()
                Spacer()
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("End Game"), message: Text("Your final score is \(score) / \(Int(questions[numberOfQuestions]) ?? 5). Wanna try again ?"), dismissButton: .default(Text("Try Again !")) {
                    multiplicand = Int.random(in: 1...12)
                    multiplier = Int.random(in: 1...multiTable)
                    result = ""
                    score = 0
                    counter = 0
                    timeRemaining = 5
                    isGameStarting = false
                })
            })
        }
        .onAppear {
            self.scaleAnimationAmountCircle = 3
        }
        .onReceive(timer) { time in
            
            if self.timeRemaining > 0 {
                withAnimation {
                    animationTimer += 360
                    self.timeRemaining -= 1
                    self.scaleAnimationAmountNumber += 0.2
                }
            }
            
            if timeRemaining == 0 {
                isGameStarting = true
            }
        }
    }
 
    
    func getRowsAndColumns() -> (Int, Int) {
        
        switch multiplicand {
        case 1...4:
            rows = 2
            columns = 2
        case 5...6:
            rows = 2
            columns = 3
        case 7...9:
            rows = 3
            columns = 3
        case 10...12:
            rows = 3
            columns = 4
        default:
            rows = 3
            columns = 2
        }
        return (rows, columns)
    }
    
    func checkAnswer(number: Int, fresult: String) {
        
        
        let correctAnswer = number * multiplier
        
        let multiResult = Int(fresult) ?? 0

        if correctAnswer == multiResult {
            score += 1
            print("Correct : \(score)")
        }

        multiplicand = Int.random(in: 1...12)
        multiplier = Int.random(in: 1...multiTable)
        animal1 = Int.random(in: 0...29)
        animal2 = Int.random(in: 0...29)
        result = ""
        print("multiplicand: \(multiplicand)")
        print(" multiplier : \(multiplier)")
        
    }
   
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(numberOfQuestions: .constant(0), multiTable: .constant(0))
    }
}
